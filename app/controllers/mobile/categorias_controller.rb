class Mobile::CategoriasController < MobileController
	def show
    @marcas_seleccionadas = params[:marca].split(",").map{|m| m.to_i } unless params[:marca].nil?
    @categoria = Categoria.includes(:productos).by_slug(params[:id]).first

    
    subcategorias = @categoria.descendants rescue []
    @subcategorias = subcategorias.reject{|r| r.parent_id != @categoria.id }

    # para encontrar productos en categorías descendientes
    catmap = [@categoria.id] + @subcategorias.map{|s| s.id } rescue []
    @marcas_para_categoria = Categoria.encontrar_marcas(catmap)



    if params[:marca].blank?
      @productos = Producto.joins(:marca).publicados.padres.where(:categoria_id => catmap).order(("marcas.marca ASC"  if params[:ordenar] == "marca")).order(preciorder(params[:precio])).order('foto_file_name ASC').page(params[:page]).per(perparams(params[:ver]))
      @productoscount = Producto.publicados.padres.where(:categoria_id => catmap).order(preciorder(params[:precio])).count
    else
      @marca = Marca.find(@marcas_seleccionadas)
      @productos = Producto.publicados.padres.where(:marca_id => @marca.map{|m| m.id }, :categoria_id => catmap).order(preciorder(params[:precio])).page(params[:page]).per(perparams(params[:ver]))
      @productoscount = Producto.publicados.padres.where(:marca_id => @marca.map{|m| m.id }, :categoria_id => catmap).count
    end
  end
end
