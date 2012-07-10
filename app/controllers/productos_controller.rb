class ProductosController < ApplicationController
  def index
    @productos = Producto.all
  end

  def new
    @producto = Producto.new
  end

  def create
    @producto = Producto.new params[:producto]
    if @producto.save
      redirect_to edit_producto_path(@producto.id)
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
      redirect_to edit_producto_path(@producto.id)
    else
      render :edit
    end
  end

  def show
    @producto = Producto.find params[:id]
  end

  def destroy
    Producto.delete params[:id]
    redirect_to :root
  end
end
