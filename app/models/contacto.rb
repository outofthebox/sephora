#encoding: UTF-8
class Contacto
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :nombre, :email, :mensaje
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => 'Tu email tiene que ser válido'
  validate :validar
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def validar
    errors.add :nombre, "Escribe tu nombre" unless self.nombre.parameterize.length >= 3
    errors.add :mensaje, "Escribe un mensaje" unless self.mensaje.parameterize.length >= 10
  end

end
