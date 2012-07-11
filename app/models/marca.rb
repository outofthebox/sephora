class Marca < ActiveRecord::Base
  validate :validar
  has_many :productos
  attr_accessible :marca, :descripcion
    before_save do
    self.slug = self.marca.parameterize if new_record?
  end
  def validar
    errors.add :marca, "Escribe una marca" unless self.marca.parameterize.length > 1
  end
end
