class AdministracionController < ApplicationController
	def landings
    @landings = Landing.all
  end

  def events
  	@events = Event.all
  end

  def store_events
  	@store_events = StoreEvent.all
  end
end
