class Mobile::TiendasController < MobileController
	def index
		@tiendas = Tienda.all(:order => 'id')
	end
end
