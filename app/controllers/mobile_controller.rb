class MobileController < ApplicationController
	def home
		@marcas = Marca.all
	end

	def download(name)
	  send_data jpg,
	    :filename => "#{name}.jpg",
	    :type => "application/jpg"
	end

	def image_url(source)
  	URI.join(root_url, image_path(source))
	end

	def favoritoslabios
		@lipsticks = Producto.where(:upc => ["811999020074", "818015018770", "3378872063827", "3378872044222", "3346470417199", "887167016583", "604214272804", "877231002109", "607710005396", "3548752047098", "607845094609"])
    @lipglosses = Producto.where(:upc => ["3348901130660", "3348901207355", "604214921351", "818015012693", "3378872057819", "3378872050391", "3605533008928", "3365440714373", "98132300419", "602004043610", "607845016717", "736150066503"])
    @lipstains = Producto.where(:upc => ["3548752057486", "877231001447", "3378872079101", "3378872081807", "94800341777", "651986501533", "607710038943", "3365440737969", "602004070432"])
    @perfectred = Producto.where(:upc => ["3378872044246", "094800341807", "877231001478", "811999020241", "604214271906", "887167016620", "607845010050", "3548752047166", "607710005310"])
	end
end
