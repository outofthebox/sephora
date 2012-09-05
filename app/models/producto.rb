class Producto < ActiveRecord::Base
  validate :validar

  belongs_to :marca
  has_many :presentaciones, :class_name => "Producto", :foreign_key => "parent_id"

  attr_accessible :nombre, :nombre_real, :sku, :parent_id, :precio, :descripcion, :ingredientes, :usos, :publicado, :marca_id, :categoria_id, :uso_id, :foto
  attr_accessor :foto

  has_attached_file :foto, {
    :styles => { :grande => "450x450", :normal => "262x262>", :mediano => "196x196>", :chico => "135x135>" }
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
        query << "to_tsvector(slug) @@ to_tsquery('#{sprintf('%s', q)}')"
      end
      productos = productos.where query.join(' OR ')
    end

    productos
  end
  
  def self.padres
    self.where :parent_id => nil
  end

  def self.publicados
    self.where :publicado => true
  end

  def self.by_slug slug
    self.where(:slug => slug).first
  end
end
