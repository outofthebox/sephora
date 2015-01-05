class Mobile::ProductosController < MobileController
	def show
    @producto = Producto.includes(:marca, :presentaciones).find_by_slug(params[:id])
    @categoria = Categoria.find(@producto.categoria_id)
    @productos_relacionados = @categoria.productos.padres.publicados.where("productos.id != ?", @producto.id).sample(3) rescue []
  end

  def hotnow
  	@seccion = Seccion.includes(:productos).by_slug('hotnow')
    @contenido = Seccion.seccion_actual(@seccion)
  end

end
