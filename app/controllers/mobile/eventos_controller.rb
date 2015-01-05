class Mobile::EventosController < MobileController
	def index
    @eventos = Event.all
    @tiendas = Tienda.all
  end

  def show
    @evento = Event.find(params[:id])
    @store_event = StoreEvent.where(:event_id => @evento.id)
  end
end
