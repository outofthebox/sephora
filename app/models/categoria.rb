class Categoria < ActiveRecord::Base
  acts_as_nested_set
  has_many :productos
  
  def self.by_slug slug
    self.where(:slug => slug)
  end
end
