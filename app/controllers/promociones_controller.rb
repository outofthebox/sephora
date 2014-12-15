class PromocionesController < ApplicationController
	def show
		@marcas_seleccionadas = params[:marca].split(",").map{|m| m.to_i } unless params[:marca].nil?
    @categoria = Categoria.first
    @subcategorias = []
    
    # para encontrar productos en categorías descendientes
    @marcas_para_categoria = Categoria.all
    
    if params[:marca].blank?
      @productos = Producto.joins(:marca).publicados.padres.where(:categoria_id => catmap).order(("marcas.marca ASC"  if params[:ordenar] == "marca")).where("productos.descuento_porcentual != 0").order(preciorder(params[:precio])).order('foto_file_name ASC').page(params[:page]).per(perparams(params[:ver]))
      @productoscount = Producto.joins(:marca).publicados.padres.where(:categoria_id => catmap).order(("marcas.marca ASC"  if params[:ordenar] == "marca")).where("productos.descuento_porcentual != 0").count
    else
      @marca = Marca.find(@marcas_seleccionadas)
      @productos = Producto.publicados.padres.where(:marca_id => @marca.map{|m| m.id }).where("productos.descuento_porcentual != 0").order(preciorder(params[:precio])).page(params[:page]).per(perparams(params[:ver]))
      @productoscount = Producto.publicados.padres.where(:marca_id => @marca.map{|m| m.id }).where("productos.descuento_porcentual != 0").count
    end
	end
end
