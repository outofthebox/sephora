#encoding: UTF-8
class Wallpaper
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_accessor :email, :imagen
  validate :validar
  def persisted?
    false
  end
  def validar
  end
end
