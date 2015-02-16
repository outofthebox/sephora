class Mobile::SeccionesController < MobileController
	def show
    @seccion = Seccion.by_slug(params[:seccion])
    @contenido = Seccion.seccion_actual(@seccion)
  end
end
