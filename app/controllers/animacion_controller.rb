class AnimacionController < ApplicationController
	def commodity
		@animacion = "commodity"
		@productos = Producto.where(upc: ["859404005124", "859404005100", "859404005087", "859404005063", "859404005049", "859404005025", "859404005179", "859404005254"])
		render "_base"
	end
	def clean
		@animacion = "clean"
		@productos = Producto.where(upc: ["874034007423", "874034007430", "874034007447", "874034007454", "874034007461", "874034007478", "874034007485", "874034007492", "874034007508"])
		render "_base"
	end
	def tocca
		@animacion = "tocca"
		@productos = Producto.where(upc: ["725490020313","725490020320","725490020214","725490020511","725490020498","725490020481","725490020665","725490020504","725490020641","725490020658","725490020740","725490020757"])
		render "_base"
	end
	def nest
		@animacion = "nest"
		@productos = Producto.where(upc: ["814972015210", "814972015203", "814972016149", "814972016132", "814972018204", "814972018211", "840732100490", "840732101220"])
		render "_base"
	end
	def beautyclasses
	end
end
