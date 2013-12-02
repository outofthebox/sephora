require "oauth"

class WishlistController < ApplicationController
	layout "wishlist"

	def self.consumer
		OAuth::Consumer.new("424407284355166","fc432bdb12fee6f1f8b650f7577e9d56", :site => 'https://graph.facebook.com', :request_endpoint => 'https://graph.facebook.com', :request_token_path => "/oauth/request_token", :access_token_path  => "/oauth/access_token", :authorize_path     => "/oauth/authorize", :sign_in => true)
	end

	def index
		maquillaje = ["3378872058915", "3548752067911", "818015014505", "604214919204", "651986904402", "607710030787", "716170118567", "3378872071488", "94800346031",  "607845038184"]
		cofres = ["8411061739587", "3607349627423", "3607349624736", "3346470115804", "8410225530459", "8411061739648", "737052629254", "3348901103244", "737052715940", "3605970567910"]
		skincare = ["808144830008", "809280119217", "687795361013", "604079102827", "651043071351", "604079104920", "879634004193", "809280119743", "604079102988", "604079103084"]
		rollerballs = ["98691048814", "809280107306", "3607345479682", "809280110504", "3607342380431", "3605970262518", "400011976644", "8034097953880", "3607342252691", "818015010026"]
		bath = ["3378872061441," "378872065609", "3378872060987", "3378872061755", "3378872066262", "3378872076865", "3378872076872", "3378872076834", "3378872076841", "2111100005081"]

		@wishlist = []
		@seccion1 = Producto.where(upc: maquillaje);
		@seccion2 = Producto.where(upc: cofres);
		@seccion3 = Producto.where(upc: skincare);
		@seccion4 = Producto.where(upc: rollerballs);
		@seccion5 = Producto.where(upc: bath);


		@seccion6 = Producto.find(Producto.pluck(:id).sample(10));
		@seccion7 = Producto.find(Producto.pluck(:id).sample(10));
		@seccion8 = Producto.find(Producto.pluck(:id).sample(10));
	end

	def ver
		@userwish = Userwish.find params[:id]
	end

	def user
		@userwish = Userwish.find params[:id]
	end

	def login
  	redirect_to "https://www.facebook.com/dialog/oauth?client_id=424407284355166&redirect_uri=https://sephoramexico.herokuapp.com/wishlist/conectar/"
	end

	def conectar
		@code = params[:code]
		redirect_to "https://graph.facebook.com/oauth/access_token?client_id=424407284355166&redirect_uri=https://sephoramexico.herokuapp.com/wishlist/nuevo&client_secret=fc432bdb12fee6f1f8b650f7577e9d56&code="+@code
	end


	def nuevo
		raise request.body.read.inspect 
		@userwish = Userwish.new
	end
end
