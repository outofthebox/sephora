class Categoria < ActiveRecord::Base
  acts_as_nested_set
  has_many :productos

  has_many :categoria_producto
  has_many :productos, :through => :categoria_producto
  
  def self.by_slug slug
    self.where(:slug => slug)
  end
end
