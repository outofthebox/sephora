class Producto < ActiveRecord::Base
  validate :validar
  belongs_to :marca
  attr_accessible :nombre, :precio, :descripcion, :ingredientes, :usos, :publicado, :marca_id, :foto
  attr_accessor :foto

  has_attached_file :foto, {
     :styles => { :normal => "262x262#", :mediano => "196x196#", :chico => "135x135#" }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  validates_attachment_presence :foto, message: 'Selecciona una foto'
  validates_attachment_content_type :foto, :content_type => ['image/jpeg', 'image/png', 'image/gif']
   
  before_save do
    self.slug = self.nombre.parameterize if new_record?
  end
  def validar
    errors.add :nombre, "Escribe un nombre" unless self.nombre.parameterize.length >= 3
    errors.add :precio, "Escribe un precio" unless self.precio.to_i > 0
  end
end
