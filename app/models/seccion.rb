class Seccion < ActiveRecord::Base
  acts_as_nested_set

  has_many :producto_seccion
  has_many :productos, :through => :producto_seccion

  def self.by_slug slug
    self.where(:slug => slug).first
  end

  def self.seccion_actual seccion
    Seccion.where(:parent_id => seccion.id, :visible => true).includes(:productos).first
  end
end
