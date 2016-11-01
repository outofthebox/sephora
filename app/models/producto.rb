require "remote_file"

class Producto < ActiveRecord::Base
  acts_as_taggable

  paginates_per 20
  validate :validar

  belongs_to :marca, inverse_of: :productos
  belongs_to :categoria

  has_many :presentaciones, :class_name => "Producto", :foreign_key => "parent_id"
  has_and_belongs_to_many :usuarios

  scope :publicados, -> { where(publicado: true) }
  scope :no_publicados, -> { where(publicado: false) }

  attr_accessible :id, :nombre, :nombre_real, :sku, :upc, :sap, :parent_id, :precio, :descripcion, :ingredientes, :usos, :publicado, :marca_id, :categoria_id, :uso_id, :foto, :image_code, :personalidad, :visto, :descuento, :descuento_porcentual
  attr_accessor :foto

  has_attached_file :foto, {
    :styles => { :grande => "450x450>", :normal => "262x262>", :mediano => "196x196>", :chico => "135x135>" },
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/productos/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  # validates_attachment_presence :foto, message: 'Selecciona una foto'
  # validates_attachment_content_type :foto, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  before_save do
    if new_record?
      self.slug = self.nombre.parameterize
      existe = Producto.where :slug => self.slug
      if existe
        unless self.sku.nil?
          self.slug = "#{self.nombre}-#{self.sku}-#{self.upc}".parameterize
        else
          self.slug = "#{self.nombre}-#{self.upc}".parameterize
        end
      end
    end
  end

  def validar
    if new_record?
      errors.add :precio, "Escribe un precio" unless self.precio.to_i > 0
      errors.add :upc, "Proporciona el UPC " unless self.upc.parameterize.length > 2
    end
  end

  def tiene_descuento
    self.descuento && self.descuento > 0 && self.descuento != nil
  end

  def nombre
    begin
      nombre_real_exists = self.nombre_real.nil? rescue false
      unless nombre_real_exists
        self.nombre_real.html_safe
      else
        super
      end
    rescue
      return ""
    end
  end

  def activo?
    self.publicado == true
  end

  def self.busqueda q
    productos = self
    if q.match(/sku:([\w]*)/)
      sku = q.match(/sku:([\w]*)/)
      productos = productos.where :sku => sku[1]
    elsif q.match(/upc:([\w]*)/)
      upc = q.match(/upc:([\w]*)/)
      productos = productos.where :upc => upc[1]
    else
      query = []
      q.parameterize.split("-").each do |q|
        query << "to_tsvector(productos.slug) @@ to_tsquery('#{sprintf('%s', q)}')"
        query << "to_tsvector(marcas.marca) @@ to_tsquery('#{sprintf('%s', q)}')"
      end
      productos = productos.select("productos.nombre, marcas.marca").joins(:marca).where query.join(' OR ')
    end

    productos
  end
  # return Producto.select("productos.*, marcas.marca").where('marcas.marca LIKE ? OR productos.nombre LIKE ?', "%#{search}%", "%#{search}%").joins(:marca)

  def self.padres
    self.where :parent_id => nil
  end

  def self.publicados
    self.where :publicado => true
  end

  def self.by_slug slug
    self.where(:slug => slug).first
  end

  def json_ld

    # Limpiando
    descripcion = self.descripcion;
    if descripcion?
      descripcion = descripcion[0..160];
    else
      descripcion = ""
    end

    js = {
      context: "http://schema.org",
      type: "Product",
      name: self.nombre,
      image: self.foto.url(:normal),
      description: descripcion,
      brand: {
        type: "Brand",
        name: self.marca.marca,
        logo: self.marca.logo.url(:grande)
      }
    }

    return js.to_json
  end

  def self.rangodeprecios cual=nil
    return self unless cual

    rango = [
      "500" => [0, 500],
      "500-1000" => [500, 1000],
      "1000-1500" => [1000, 1500],
      "1500-2000" => [1500, 2000],
      "2000" => [2000]
    ].first

    mirango = (rango.keys & [cual]).first
    mirango = rango.keys.first if mirango.nil?

    self.where("productos.precio > ? AND productos.precio <= ?", rango[mirango][0], rango[mirango][1])
  end


  def self.update_precios(file, update_prices = false)
    data = []

    i = URI(file)

    scheme = i.scheme
    host = i.host
    path = i.path rescue '/'
    query = i.query rescue ''

    host_path = "#{scheme}://#{host}"
    full_path = "#{scheme}://#{host}#{path}#{query}"

    conn = Faraday.new(:url => host_path) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    request = conn.get do |req|
      req.url "#{path}#{query}"
      req.headers['Accept'] = 'application/csv'
    end

    csv = CSV.parse(request.body, :headers => false)

    #csv.each do |row| code = row[0]; precio_nuevo = row[1]; precio_nuevo = precio_nuevo.to_f;   data << {:code => code, :precio_nuevo => precio_nuevo}; end

    all_products = Producto.where(upc: csv.map{|x| x[0]}).map{|prod| {id: prod.id, upc: prod.upc, precio: prod.precio.to_f}}

    nuevos_precios = csv.map do |row|
      {upc: row[0], nuevo_precio: row[1].to_f}
    end

    productos = (all_products+nuevos_precios).group_by{|h| h[:upc]}.map{|k,v| v.reduce(:merge)}.select{|x| x[:id].present?}

    ids = productos.map{|x| x[:id]}
    update_vals = productos.map{|x| {precio: x[:nuevo_precio]}}

    Producto.update(ids, update_vals) if update_prices == true 

    return productos
  end

  def self.descontinuar(file, descontinuar_productos = false)
    rm = RemoteFile.new(file)
    csv = CSV.parse(rm.request.body, :headers => false)

    data = csv.map{|x| x[0]}.select{|y| !y.nil?} rescue []
    
    descontinuados_before =  Producto.where(:publicado => false).count rescue 0

    descontinuados = Producto.where(:upc => data)
    
    if descontinuar_productos == true
      descontinuados.update_all({publicado: false});
      descontinuados_after =  Producto.where(:publicado => false).count
    else
      descontinuados_after = descontinuados.count rescue 0
    end

    response = {
      before: descontinuados_before,
      after: descontinuados_after
    }

    return response
  end
end







































