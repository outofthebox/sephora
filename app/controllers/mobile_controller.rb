class MobileController < ApplicationController
	def home
		@marcas = Marca.all
	end

	def download(name)
	  send_data jpg,
	    :filename => "#{name}.jpg",
	    :type => "application/jpg"
	end

	def politicas
		render "paginas/politicas"
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

	def favoritosmascarillas
	  @hidratantes = Producto.where(:upc => ["809280009037", "3378872082286", "713757240833", "736211449719", "808144215010", "670367404058"])
	  @antiedad = Producto.where(:upc => ["809280101526", "3378872082309", "670367000540", "670367001653", "651043024517", "651473531807"])
	  @multibeneficios = Producto.where(:upc => ["651043021523", "670367001257", "713757241830", "736211224262", "808144250011", "808144350018"])
	  @denoche = Producto.where(:upc => ["808144222018", "20714576219", "670367011867"])
	end

	def mascarillashidratantes; end
	def mascarillasantiedad; end
	def mascarillasmultibeneficio; end
	def mascarillasnocturnas; end
end
