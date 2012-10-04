class Producto < ActiveRecord::Base
    paginates_per 20
  validate :validar

  belongs_to :marca
  has_many :presentaciones, :class_name => "Producto", :foreign_key => "parent_id"

  attr_accessible :nombre, :nombre_real, :sku, :upc, :parent_id, :precio, :descripcion, :ingredientes, :usos, :publicado, :marca_id, :categoria_id, :uso_id, :foto
  attr_accessor :foto

  has_attached_file :foto, {
    :styles => { :grande => "450x450>", :normal => "262x262>", :mediano => "196x196>", :chico => "135x135>" }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  # validates_attachment_presence :foto, message: 'Selecciona una foto'
  # validates_attachment_content_type :foto, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  before_save do
    if new_record?
      self.slug = self.nombre.parameterize
      existe = Producto.where :slug => self.slug
      if existe
        self.slug = "#{self.nombre}-#{self.sku}".parameterize
      end
    end
  end

  def validar
    errors.add :nombre, "Escribe un nombre" unless self.nombre.parameterize.length >= 3
    errors.add :precio, "Escribe un precio" unless self.precio.to_i > 0
    errors.add :sku, "Proporciona el SKU " unless self.sku.parameterize.length > 2
  end

  def self.busqueda q
    productos = self
    if sku = q.match(/sku:([\w]*)/)
      productos = productos.where :sku => sku[1]
    else
      query = []
      q.parameterize.split("-").each do |q|
        query << "to_tsvector(productos.slug) @@ to_tsquery('#{sprintf('%s', q)}')"
        query << "to_tsvector(marcas.marca) @@ to_tsquery('#{sprintf('%s', q)}')"
      end
      productos = productos.select("productos.*, marcas.marca").joins(:marca).where query.join(' OR ')
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
end
