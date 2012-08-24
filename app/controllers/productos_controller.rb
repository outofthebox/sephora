class ProductosController < ApplicationController

  def index
    @productos = Producto.includes(:marca).where(:publicado => true).page(params[:page]).per(50)
  end

  def busqueda
    @productos = Producto.includes(:marca).busqueda params[:q]
    respond_to do |format|
      format.js if request.xhr?
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
    authorize! :manage, @producto
    if @producto.update_attributes params[:producto]
      redirect_to producto_ver_path(@producto.slug)
    else
      render :edit
    end
  end

  def show
    @producto = Producto.publicados.by_slug(params[:slug])
    @categoria = Categoria.find(@producto.categoria_id)
    @productos_relacionados = @categoria.productos.where("id != ?", @producto.id).publicados
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
