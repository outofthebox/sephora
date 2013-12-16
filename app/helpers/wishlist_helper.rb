

module WishlistHelper
	def make_link(id)
		md = id.match /(\d*)_(\d*)/
		url = "http://www.facebook.com/"
		url += md[1];
		url += "/"+md[2]+"/"
		puts url
	end
end
