class Seccion < ActiveRecord::Base
  acts_as_nested_set

  has_many :producto_seccion
  has_many :productos, :through => :producto_seccion
end
