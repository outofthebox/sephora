class Wishlist < ActiveRecord::Base
	self.primary_key = "producto_id"

	has_many :productos, :class_name => "Producto"
	has_many :userwishes, :class_name => "Userwish"

end
