class ProductosController < ApplicationController
  def index
    @productos = Producto.includes(:marca).where :publicado => true
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
    @producto = Producto.where(:slug => params[:slug], :publicado => true).first
  end

  def importar
    raise 'error' unless Rails.env.development?

    require 'csv'
    datos = []
    CSV.foreach("/home/sputnik3/Desktop/sephora.csv") do |row|
      sku = row[1]
      nombre = row[5]
      nombre_real = row[6]
      precio = row[11]
      descripcion = row[12]
      usos = row[13]
      ingredientes = row[14]
      datos << { :sku => sku, :nombre => nombre, :nombre_real => nombre_real, :precio => precio, :descripcion => descripcion, :usos => usos, :ingredientes => ingredientes } if sku.length > 3
    end

    datos = datos.drop 1

    datos.each do |dato|
      p = Producto.new dato
      p.save(:validate => false )
    end

    raise datos.inspect
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
