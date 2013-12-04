class Wishlist < ActiveRecord::Base
	has_many :productos, :class_name => "Producto"
	has_many :userwishes, :class_name => "Userwish"
end
