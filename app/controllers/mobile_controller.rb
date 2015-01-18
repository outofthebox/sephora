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
end
