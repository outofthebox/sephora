require 'riddle'
class ProductosController < ApplicationController

  def index
    @productos = Producto.includes(:marca).padres.order("updated_at DESC").page(params[:page]).per(50)
    authorize! :manage, @productos
  end



  def busqueda2
    query = params[:buscar][:q];
    productos = Producto.search Riddle.escape(query);
    raise productos.inspect
  end


  def busqueda

    params[:buscar][:q] = params[:buscar][:q].gsub(/\//, " ")
    @marcas_seleccionadas = params[:marca].split(",").map{|m| m.to_i } unless params[:marca].nil?
    
    base = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :star => true)
    
    if @marcas_seleccionadas.nil? || @marcas_seleccionadas.empty? 
      @productos_filtrados = base
    else
      @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0, :marca_id => @marcas_seleccionadas})
    end

    if params[:ordenar] == "marca"
      @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :order => 'marca ASC', :star => true)
    end

    if params[:precio]
      arrange = params[:precio]
      if arrange == 'alto'
        @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :order => 'precio DESC', :star => true)
      elsif arrange == 'bajo'
        @productos_filtrados = Producto.search(params[:buscar][:q], :with => {:publicado => true, :parent_id => 0}, :order => 'precio ASC', :star => true)
      end
    end

    @productos = @productos_filtrados.page(params[:page]).per(perparams(params[:ver]))
    @count = @productos_filtrados.count
    a = []
    base.each do |r|
      a << r.marca
    end
    @marcas_para_categoria = a.compact.uniq.sort
  end

  def busqueda_old
    @filtrame = Producto.includes(:marca).padres.publicados.order(("marcas.marca ASC"  if params[:ordenar] == "marca")).order(preciorder(params[:precio])).busqueda(params[:q] || params[:buscar][:q])
    @marcas_seleccionadas = params[:marca].split(",").map{|m| m.to_i } unless params[:marca].nil?
    if params[:marca].blank?
      @productos = Producto.includes(:marca).padres.publicados.order(("marcas.marca ASC"  if params[:ordenar] == "marca")).order(preciorder(params[:precio])).busqueda(params[:q] || params[:buscar][:q]).page(params[:page]).per(perparams(params[:ver]))
    else
      @marca = Marca.find(@marcas_seleccionadas)
      @productos = Producto.includes(:marca).padres.publicados.where(:marca_id => @marca.map{|m| m.id }).order(("marcas.marca ASC"  if params[:ordenar] == "marca")).order(preciorder(params[:precio])).busqueda(params[:q] || params[:buscar][:q]).page(params[:page]).per(perparams(params[:ver]))
    end
    a = []
    @filtrame.each do |r|
      a << r.marca
    end
    @marcas_para_categoria = a.compact.uniq.sort
    @productostotal = Producto.includes(:marca).padres.publicados.busqueda(params[:q] || params[:buscar][:q])
    @productoscount = Producto.includes(:marca).padres.publicados.busqueda(params[:q] || params[:buscar][:q]).count
    respond_to do |format|
      format.js if request.xhr?
      format.html
    end
  end

  def new
    @producto = Producto.new
    authorize! :manage, @producto
  end

  def create
    @producto = Producto.new params[:producto]
    authorize! :manage, @producto
    if @producto.save
      redirect_to producto_ver_path(@producto.slug)
    else
      render :new
    end
  end

  def edit
    @producto = Producto.find params[:id]
    authorize! :manage, @producto
  end

  def update
    @producto = Producto.find params[:id]
    if @producto.update_attributes params[:producto]
      redirect_to producto_ver_path(@producto.slug)
    else
      render :edit
    end
    authorize! :manage, @producto
  end

  def show
    @producto = Producto.includes(:marca, :presentaciones).publicados.where(:slug => params[:slug]).first
    visto = @producto.visto;
    
    if(visto == nil) 
      visto = 1; 
    else 
      visto = visto + 1; 
    end
    
    Producto.update(@producto.id, {:visto=>visto})
    
    @categoria = Categoria.find(@producto.categoria_id)
    @productos_relacionados = @categoria.productos.padres.publicados.where("productos.id != ?", @producto.id).sample(3)
  end

  def index_admin
    @productos = Producto.all
    authorize! :manage, @productos
    render :index
  end
  
  def destroy
    Producto.delete params[:id]
    authorize! :manage, :destroy
    redirect_to :root
  end
end
