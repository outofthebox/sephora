class Mobile::EventosController < MobileController
	def index
    #m = [78, 93, 75, 92, 79, 77, 76, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91]
    #n = m & Event.where({id: m}).pluck(:id)
    #@eventos = Event.where({id: n}).index_by(&:id).values_at(*n) rescue []
    @eventos = Event.all
    @tiendas = Tienda.all
  end

  def show
    @evento = Event.find(params[:id])
    @store_event = StoreEvent.where(:event_id => @evento.id)
  end
end
