class Administracion::EventsController < ApplicationController
	http_basic_authenticate_with :name => ENV['U'], :password => ENV['P']
  layout "administracion"
	before_filter :set_event, :except => [:new]

	def new
		@event = Event.new
		@tiendas = Tienda.all
	end

	def create
		event = Event.new(event_params)
    tiendas_params.each do |tp|
    	if tp && tp[:activo] == "on"
    		tienda_id = tp[:tienda_id]
    		link = tp[:link]
    		date = tp[:date].inspect
	    	she = StoreHasEvent.new(:tienda_id=> tienda_id, :link => link, :dates => date, :event_id => event.id)
	    	if she.save
	    		event.store_has_events << she
	    	end
	    end
    end
    if event.save
    	redirect_to admin_event_path
    end
	end

	def edit
		@tiendas = Tienda.all
	end

  def update
    event = Event.find(params[:id])
    tiendas_params.each do |tp|
    	if tp && tp[:activo] == "on"
    		tienda_id = tp[:tienda_id]
    		link = tp[:link]
    		date = tp[:date].inspect
    		if tp[:id]
    			she = StoreHasEvent.find(tp[:id])
    			she.update_attributes({:tienda_id=> tienda_id, :link => link, :dates => date, :event_id => event.id})
    		else
		    	she = StoreHasEvent.create(:tienda_id=> tienda_id, :link => link, :dates => date, :event_id => event.id)
		    end
	    end
    end
    event.update_attributes(event_params)
    redirect_to admin_event_path
  end

	private
	  def set_event
	  	@event = Event.find(params[:id]) rescue nil
	  end

	  def event_params
	  	params[:event]
	  end

	  def tiendas_params
	  	params[:tienda]
	  end
end
