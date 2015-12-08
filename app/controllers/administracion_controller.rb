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

  def photogram
    all_subscriptions = Instagram.subscriptions
    @subscriptions = []
    all_subscriptions.each do |s|
      @subscriptions << OpenStruct.new(s)
    end
  end
end
