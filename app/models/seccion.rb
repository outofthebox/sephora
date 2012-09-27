class Seccion < ActiveRecord::Base
  acts_as_nested_set

  has_many :producto_seccion
  has_many :productos, :through => :producto_seccion
  has_attached_file :cover, :styles => { :normal => "754x240>", :mini => "251x80>" }.merge(PAPERCLIP_STORAGE_OPTIONS)
  before_create do
    self.slug = self.nombre.parameterize.gsub /[^(\w)]/, '' if self.parent_id.nil?
  end

  def self.by_slug slug
    self.where(:slug => slug).first
  end

  def self.seccion_actual seccion
    unless seccion.nil?
      Seccion.where(:parent_id => seccion.id, :visible => true).includes(:productos).first
    end
  end

  def self.subsecciones seccion, id=nil
    unless seccion.nil?
      seccion1 = Seccion.where(:parent_id => seccion.id, :visible => true).includes(:productos)
      seccion1 = seccion1.find(id) unless id.nil?
      seccion1
    end
  end
end
