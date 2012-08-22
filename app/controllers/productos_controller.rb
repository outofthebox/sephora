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
  end

  def create
    @producto = Producto.new params[:producto]
    if @producto.save
      redirect_to producto_ver_path(@producto.slug)
    else
      render :new
    end
  end

  def edit
    @producto = Producto.find params[:id]
  end

  def update
    @producto = Producto.find params[:id]
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
    render :index
  end
  
  def destroy
    Producto.delete params[:id]
    redirect_to :root
  end
end
