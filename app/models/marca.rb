class Marca < ActiveRecord::Base
  has_many :productos

  attr_accessible :marca, :descripcion, :slug, :logo, :promo
  attr_accessor :logo, :promo

  has_attached_file :logo, {
    :styles => { :grande => "300x300#", :normal => "200x200#", :mini => "100x100#" }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :promo, {
    :styles => { :grande => "300x300#", :normal => "200x200#", :mini => "100x100#" }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  validate :validar

  before_save do
    self.slug = self.marca.parameterize if new_record?
  end

  def validar
    errors.add :marca, "Escribe una marca" unless self.marca.parameterize.length > 1
  end
end
