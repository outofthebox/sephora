class Categoria < ActiveRecord::Base
  has_many :productos
  def self.by_slug slug
    self.where(:slug => slug)
  end
end
