class MobileController < ApplicationController
  before_filter :authenticate_mobileuser!, :only => [:favoritos]
  def home
  end

  def especialmes
  end

  def giftcase
    especialesmes = "case";
    user = current_mobileuser
    @unique = nil;
    if(user.id <= 50) 
      @unique = Digest::MD5.hexdigest(user.email+especialesmes);
    end
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

  def lomas
    @productos = Producto.order("visto ASC").first(5);
  end

  def favoritos
    user = current_mobileuser

    @productos = [];

    json_favs = JSON.parse(user.favoritos)
    json_favs.each do |f|
      @productos << Producto.where(:upc => f["id"]).first;
    end
  end
  
  def favorite
    require 'json'
    
    @user = current_mobileuser
    
    le_id = params[:id].scan(/\d+$/).first;

    if @user.favoritos.empty?
      favs = [{:id => le_id}]
    else
      favs = JSON.parse @user.favoritos
      favs << {:id => le_id}
    end

    @user.favoritos = favs.to_json
    
    if @user.save
      redirect_to  m_favoritos_path
    else
      redirect_to  m_favoritos_path
    end

  end

  def unfavorite
    require 'json'
    
    user = current_mobileuser
    counter = 0;
    le_id = params[:id].scan(/\d+$/).first;
    le_product = Producto.find(le_id);
    le_upc = le_product.upc;

    favs = JSON.parse user.favoritos
    favs.each do |f|
      if(le_upc == f["id"]) 
        favs.slice!(counter)
      end
      counter = counter + 1;
    end

    user.favoritos = favs.to_json
    
    if user.save
      redirect_to  m_favoritos_path
    else
      redirect_to  m_favoritos_path
    end

  end
end
