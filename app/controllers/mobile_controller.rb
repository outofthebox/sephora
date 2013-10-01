class MobileController < ApplicationController
  before_filter :authenticate_mobileuser!, :only => [:favoritos]
  def home
  end

  def mobilbusqueda
    params[:buscar][:q] = params[:buscar][:q].gsub(/\//, " ")
    @marcas_seleccionadas = params[:marca].split(",").map{|m| m.to_i } unless params[:marca].nil?
    base = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0})
    if @marcas_seleccionadas.nil? || @marcas_seleccionadas.empty? 
      @productos_filtrados = base
    else
      @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0, :marca_id => @marcas_seleccionadas})
    end
    if params[:ordenar] == "marca"
      @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :order => 'marca ASC')
    end
    if params[:precio]
      arrange = params[:precio]
      if arrange == 'alto'
        @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :order => 'precio DESC')
      elsif arrange == 'bajo'
        @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :order => 'precio ASC')
      end
    end
    @productos = @productos_filtrados.page(params[:page]).per(perparams(params[:ver]))
    @count = @productos_filtrados.ocunt
    a = []
    base.each do |r|
      a << r.marca
    end
    @marcas_para_categoria = a.compact.uniq.sort
  end

  def mobileproducto
    @producto = Producto.includes(:marca, :presentaciones).publicados.where(:slug => params[:slug]).first
    @categoria = Categoria.find(@producto.categoria_id)
    @productos_relacionados = @categoria.productos.padres.publicados.where("productos.id != ?", @producto.id).sample(3)
  end

  def tiendas
    @tiendas = Tienda.all
  end
  def lonuevo
    @lonuevo = Seccion.seccion_actual(Seccion.by_slug(:lonuevo))
  end
  def jotnao
    @seccion = Seccion.by_slug(params[:seccion])
    @contenido = Seccion.seccion_actual(@seccion)
  end
  def favoritos
    @productos = Producto.find(JSON.parse(current_mobileuser.favoritos))
  end
  def favorite
    require 'json'
    @user = current_mobileuser
    if @user.favoritos.empty?
      favs = "[#{params[:id]}]"
    else
      favoritos = JSON.parse @user.favoritos
      id_producto = params[:id].to_i
      if (favoritos & [id_producto]).empty?
        favs = (favoritos + [id_producto]).to_s
      else
        favs = favoritos
      end
    end
    @user.favoritos = favs
    if @user.save
      redirect_to  m_favoritos_path
    else
      redirect_to  m_favoritos_path
    end
  end
end
