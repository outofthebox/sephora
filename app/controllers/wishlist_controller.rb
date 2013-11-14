class WishlistController < ApplicationController
	layout "wishlist"

	def index
		# prods1 = [8272, 8275, 8276, 8277, 8278, 8279, 8280, 8281, 8282, 8285]
		# prods2 = [8286, 8287, 8290, 8291, 8292, 8293, 8298, 8299, 8300, 8302]
		# prods3 = [8303, 8306, 8312, 8319, 8323, 8324, 8327, 8331, 8273, 8274]
		# prods4 = [8285, 8296, 8297, 8298, 8301, 8302, 8304, 8306, 8307, 8308]
		# prods5 = [8309, 8310, 8311, 8313, 8314, 8318, 8319, 8320, 8321, 8323]
		# prods6 = [8324, 8325, 8328, 8329, 8330, 8331, 8319, 8320, 8321, 8323]
		# prods7 = [8303, 8306, 8312, 8319, 8323, 8324, 8327, 8331, 8273, 8274]
		# prods8 = [8309, 8310, 8311, 8313, 8314, 8318, 8319, 8320, 8321, 8323]

		@wishlist = Producto.find(Producto.pluck(:id).sample(10));
		@seccion1 = Producto.find(Producto.pluck(:id).sample(10));
		@seccion2 = Producto.find(Producto.pluck(:id).sample(10));
		@seccion3 = Producto.find(Producto.pluck(:id).sample(10));
		@seccion4 = Producto.find(Producto.pluck(:id).sample(10));
		@seccion5 = Producto.find(Producto.pluck(:id).sample(10));
		@seccion6 = Producto.find(Producto.pluck(:id).sample(10));
		@seccion7 = Producto.find(Producto.pluck(:id).sample(10));
		@seccion8 = Producto.find(Producto.pluck(:id).sample(10));
	end
end
