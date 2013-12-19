class BlogCategoria < ActiveRecord::Base
  attr_accessible :categoria
  acts_as_nested_set
end
