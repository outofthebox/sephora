class Producto < ActiveRecord::Base
  validate :validar
  attr_accessible :nombre, :precio, :descripcion, :ingredientes, :usos, :publicado
  before_save do
    self.slug = self.nombre.parameterize if new_record?
  end
  def validar
    errors.add :nombre, "Escribe un nombre" unless self.nombre.parameterize.length >= 3
    errors.add :precio, "Escribe un precio" unless self.precio.to_i > 0
  end
end
