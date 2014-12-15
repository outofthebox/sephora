class PromocionesController < ApplicationController
	def show
		@marcas_seleccionadas = params[:marca].split(",").map{|m| m.to_i } unless params[:marca].nil?
    
    @categoria = (params[:categoria]) ? Categoria.includes(:productos).by_slug(params[:categoria]).first : nil
    
    if @categoria
    	subcategorias = @categoria.descendants
    	@subcategorias = subcategorias.reject{|r| r.parent_id != @categoria.id }
	    catmap = [@categoria.id] + @subcategorias.map{|s| s.id }
	    @marcas_para_categoria = Categoria.encontrar_marcas(catmap)
	    if params[:marca].blank?
	      @productos = Producto.joins(:marca).publicados.padres.where(:categoria_id => catmap).where("productos.descuento_porcentual != 0").order(("marcas.marca ASC"  if params[:ordenar] == "marca")).order(preciorder(params[:precio])).order('foto_file_name ASC').page(params[:page]).per(perparams(params[:ver]))
	      @productoscount = Producto.publicados.padres.where(:categoria_id => catmap).where("productos.descuento_porcentual != 0").order(preciorder(params[:precio])).count
	    else
	      @marca = Marca.find(@marcas_seleccionadas)
	      @productos = Producto.publicados.padres.where(:marca_id => @marca.map{|m| m.id }, :categoria_id => catmap).where("productos.descuento_porcentual != 0").order(preciorder(params[:precio])).page(params[:page]).per(perparams(params[:ver]))
	      @productoscount = Producto.publicados.padres.where(:marca_id => @marca.map{|m| m.id }, :categoria_id => catmap).where("productos.descuento_porcentual != 0").count
	    end
    else
	    if params[:marca].blank?
	      @productos = Producto.joins(:marca).publicados.padres.order(("marcas.marca ASC"  if params[:ordenar] == "marca")).where("productos.descuento_porcentual != 0").order(preciorder(params[:precio])).order('foto_file_name ASC').page(params[:page]).per(perparams(params[:ver]))
	      @productoscount = Producto.joins(:marca).publicados.padres.order(("marcas.marca ASC"  if params[:ordenar] == "marca")).where("productos.descuento_porcentual != 0").count
	    else
	      @marca = Marca.find(@marcas_seleccionadas)
	      @productos = Producto.publicados.padres.where(:marca_id => @marca.map{|m| m.id }).where("productos.descuento_porcentual != 0").order(preciorder(params[:precio])).page(params[:page]).per(perparams(params[:ver]))
	      @productoscount = Producto.publicados.padres.where(:marca_id => @marca.map{|m| m.id }).where("productos.descuento_porcentual != 0").count
	    end
	    @categorias = Categoria.where(:id => Producto.pluck(:categoria_id).uniq)
	  end

	end
end
