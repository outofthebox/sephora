class Categoria < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :nombre, :parent_id, :cover
  attr_accessor :cover

  has_attached_file :cover, {
    :styles => { :normal => "768x250#", :mini => "256x83#" }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_many :productos

  has_many :categoria_producto
  has_many :productos, :through => :categoria_producto
  
  def self.by_slug slug
    self.where(:slug => slug)
  end
end
