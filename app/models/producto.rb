class Producto < ActiveRecord::Base
  validate :validar
  belongs_to :marca
  attr_accessible :nombre, :nombre_real, :sku, :precio, :descripcion, :ingredientes, :usos, :publicado, :marca_id, :categoria_id, :uso_id, :foto
  attr_accessor :foto

  has_attached_file :foto, {
    :styles => { :normal => "262x262#", :mediano => "196x196#", :chico => "135x135#" }
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

  def self.publicados
    self.where :publicado => true
  end

  def self.by_slug slug
    self.where(:slug => slug).first
  end
end
