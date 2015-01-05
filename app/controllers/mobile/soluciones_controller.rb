class Mobile::SolucionesController < MobileController
	def show
		@seccion = Seccion.by_slug(:soluciones)
    @subsecciones = Seccion.subsecciones(@seccion)

    @solucion = Seccion.subsecciones(@seccion, params[:id])
	end
end
