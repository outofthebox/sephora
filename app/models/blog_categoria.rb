class BlogCategoria < ActiveRecord::Base
  attr_accessor :categoria
  acts_as_nested_set
end
