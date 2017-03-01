class CarruselController < ApplicationController
	def show
		@animation = AnimationCarousel.find_by_slug(params[:slug])
	end

end
