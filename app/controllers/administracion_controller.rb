class AdministracionController < ApplicationController
	def landings
    @landings = Landing.all
  end

  def events
  	@events = Event.all
  end
end
