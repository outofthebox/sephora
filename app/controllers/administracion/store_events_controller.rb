class Administracion::StoreEventsController < ApplicationController
	http_basic_authenticate_with :name => ENV['U'], :password => ENV['P']
	before_filter :set_store_event, :only => [:destroy, :edit, :update]
  layout "administracion"

	def new
		@store_event = StoreEvent.new
	end

	def create
		se = StoreEvent.new(params_store_event)
		if se.save!
			redirect_to admin_store_event_path
		end
	end

	def update
		@store_event.update_attributes(params_store_event)
		redirect_to admin_store_event_path
	end

	def edit
	end

	def destroy
		if @store_event.destroy
			redirect_to admin_store_event_path
		end
	end


	def params_store_event
		params[:store_event]
	end

	def set_store_event
		@store_event = StoreEvent.find(params[:id])
	end
end