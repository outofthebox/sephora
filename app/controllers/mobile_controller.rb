class MobileController < ApplicationController
	def download(name)
	  send_data jpg,
	    :filename => "#{name}.jpg",
	    :type => "application/jpg"
	end

	def image_url(source)
  	URI.join(root_url, image_path(source))
	end
end
