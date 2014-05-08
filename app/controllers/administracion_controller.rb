class AdministracionController < ApplicationController
	def landings
    @landings = Landing.all
  end
end
