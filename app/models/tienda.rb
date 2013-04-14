class Tienda < ActiveRecord::Base
  attr_accessible :nombre, :direccion, :horario, :latitud, :longitud, :contacto, :foto, :slug, :mapa

  has_attached_file :foto, {
    :styles => { :normal => "142x142>" }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  before_save do
    self.slug = self.nombre.parameterize if new_record?
  end
end
