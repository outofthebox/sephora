require "oauth"

class WishlistController < ApplicationController
	layout "wishlist"

	before_filter :authenticate, :only => [:admin]

	def lista
		maquillaje = ["3378872058915", "3548752067911", "818015014505", "604214919204", "651986904402", "607710030787", "716170118567", "3378872071488", "94800346031",  "607845038184"]
		cofres = ["8411061739587", "3607349627423", "3607349624736", "3346470115804", "8410225530459", "8411061739648", "737052629254", "3348901103244", "737052715940", "3605970567910"]
		skincare = ["094800345850", "767332805306", "808144830008", "809280119217", "687795361013", "604079102827", "651043071351", "604079104920", "879634004193", "809280119743"]
		rollerballs = ["98691048814", "809280107306", "3607345479682", "809280110504", "3607342380431", "3605970262518", "400011976644", "8034097953880", "3607342252691", "818015010026"]
		bath = ["604079103084", "604079102988", "3378872061441," "378872065609", "3378872060987", "3378872076865", "3378872076872", "3378872076834", "3378872076841", "2111100005081"]

		@wishlist = []
		@seccion1 = Producto.where(upc: maquillaje);
		@seccion2 = Producto.where(upc: skincare);
		@seccion3 = Producto.where(upc: bath);
		@seccion4 = Producto.where(upc: cofres);
		@seccion5 = Producto.where(upc: rollerballs);

	end

	def admin
		@usuarios = Userwish.all
	end

	def authenticate
    authenticate_or_request_with_http_basic do |user, password| 
        session[:admin]= (user == ENV['U'] && password == ENV['P'])
    end
  end

	def user
		existo = Userwish.where(:uid => params[:uid]).first
		if existo != nil
			wishlist = Wishlist.where(:userwish_id => existo.id).select("producto_id").first(5)
			@seccion1 = Producto.includes(:wishlist).where(:id => wishlist).first(5)
		else
			Userwish.update(existo.id, :access_token => params[:token])
			redirect_to :wishlist_lista
		end
	end

	def ver
		existo = Userwish.where(:uid => params[:uid]).first
		if existo != nil
			wishlist = Wishlist.where(:userwish_id => existo.id).select("producto_id").first(5)
			@seccion1 = Producto.includes(:wishlist).where(:id => wishlist).first(5)
		else
			redirect_to :wishlist_lista
		end
	end

	def nuevo
		@wishlist = [params[:producto1], params[:producto2], params[:producto3], params[:producto4], params[:producto5]];

		@seccion1 = Producto.where(upc: @wishlist);

		leuser = {:provider => "facebook", :access_token => params[:token], :uid => params[:uid], :name => "", :post_id => params[:post_id]}

		existo = Userwish.where(:uid => params[:uid]).first;
		
		if(existo != nil)
			if Userwish.update(existo, leuser)
				@seccion1.each do |product|
					leproduct = {:producto_id => product.id, :userwish_id => existo.id}
					new_wishlist = Wishlist.new(leproduct);
					if new_wishlist.save
						puts "[producto salvado]"
					else
						puts "[error al salvar wishlist]"
					end
				end
				redirect_to "/wishlist/mi_lista/"+existo.uid
			else
				redirect_to :wishlist_error
			end
		else
			@userwish = Userwish.new(leuser)
			if @userwish.save
				@seccion1.each do |product|
					leproduct = {:producto_id => product.id, :userwish_id => @userwish.id}
					new_wishlist = Wishlist.new(leproduct);
					if new_wishlist.save
						puts "[producto salvado]"
					else
						puts "[error al salvar wishlist]"
					end
				end
				redirect_to "/wishlist/mi_lista/"+@userwish.uid
			else
				redirect_to :wishlist_error
			end
		end
	end
end
