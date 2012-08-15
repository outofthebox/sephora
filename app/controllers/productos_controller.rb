class ProductosController < ApplicationController
  def index
    @productos = Producto.includes(:marca).where(:publicado => true)
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

    csv = "/home/sputnik3/Desktop/sephora.csv"

    require 'csv'
    datos = []

    case params[:quoi]
    when 'marcas'
      marcas = []
      categorias = []
      usos = []
      CSV.foreach(csv) do |row|
        marcas << row[4]
        categorias << row[8]
        categorias << row[9]
        usos << row[10]
      end

      usos = usos.sort.uniq.map do |u|
        Uso.new :nombre => u, :visible => true
      end
      Uso.import usos

      categorias = categorias.sort.uniq.map do |c|
        Categoria.new :nombre => c, :slug => c.parameterize, :visible => true
      end
      Categoria.import categorias

      marcas = marcas.sort.uniq.map do |m|
        Marca.new :marca => m, :slug => m.parameterize
      end
      Marca.import marcas

      raise 'hecho!'
    else
      marcas = Marca.all.map{|m| { :id => m.id, :marca => m.marca } }
      categorias = Categoria.all.map{|c| { :id => c.id, :categoria => c.nombre } }
      # usos = Uso.all.map{|u| { :id => u.id, :uso => u.nombre } }
      CSV.foreach(csv) do |row|
        sku = row[1]
        categoria_id = categorias.map{|c| row[9].parameterize == c[:categoria].parameterize ? c[:id] : nil }.compact.first
        marca_id = marcas.map{|m| row[4].parameterize == m[:marca].parameterize ? m[:id] : nil }.compact.first
        # uso_id = usos.map{|u|
        #   row[10].parameterize == u[:uso].parameterize ? u[:id] : nil
        # }.compact.first
        nombre = row[5]
        nombre_real = row[6]
        precio = row[11]
        descripcion = row[12]
        usos = row[13]
        ingredientes = row[14]
        datos << { :sku => sku, :nombre => nombre, :nombre_real => nombre_real, :precio => precio, :descripcion => descripcion, :usos => usos, :ingredientes => ingredientes, :marca_id => marca_id, :categoria_id => categoria_id } if sku.length > 3
      end

      # datos = datos.drop 1

      datos.each do |dato|
        p = Producto.new dato
        p.save(:validate => false )
      end

      raise datos.inspect
    end
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
