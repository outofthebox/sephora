class MarcasController < ApplicationController
  def index
    @marcas = Marca.all
  end

  def new
    @marca = Marca.new
    authorize! :manage, @marca
  end

  def create
    @marca = Marca.new params[:marca]
    authorize! :manage, @marca
    if @marca.save
      redirect_to marca_ver_path(@marca.slug)
    else
      render :new
    end
  end

  def edit
    @marca = Marca.find params[:id]
    authorize! :manage, @marca
  end

  def update
    @marca = Marca.find params[:id]
    authorize! :manage, @marca
    if @marca.update_attributes params[:marca]
      redirect_to marca_ver_path(@marca.slug)
    else
      render :edit
    end
  end

  def show
    @marca = Marca.includes(:marca_producto, :featured).where(:slug => params[:slug]).first
  end

  def destroy
    Marca.delete params[:id]
    authorize! :manage, :destroy
    redirect_to marcas_path
  end

  # Vínculos

  def vincular
    marca = Marca.find params[:id]
    authorize! :manage, marca
    vinculo = marca.marca_producto.build params[:marca_producto]
    if vinculo.valid?
      vinculo.save
    end
    redirect_to edit_marca_path(marca.id)
  end

  def desvincular
    marca = Marca.find params[:id]
    authorize! :manage, marca
    marca_producto = marca.marca_producto.find params[:marca_producto]

    if check_minihash(marca_producto, params[:hash])
      marca_producto.destroy
    end

    redirect_to edit_marca_path(marca.id)
  end

  def producto_editar
    @marca = Marca.find params[:id]
    authorize! :manage, @marca
    @marca_producto = @marca.marca_producto.find params[:v_id]
  end

  def producto_update
    marca = Marca.find params[:id]
    authorize! :manage, marca
    marca_producto = marca.marca_producto.find(params[:v_id])
    marca_producto.update_attributes params[:marca_producto]
    if marca_producto.valid?
      marca_producto.save
      redirect_to marca_editar_producto_path(marca.id, marca_producto.id)
    else
      render :producto_editar
    end
  end

  def actualizar_orden
    vinculos = params[:vinculo_id]
    orden = (0...vinculos.size)

    marcaProducto.update( vinculos, orden.map{|o| { :orden => o }}).reject { |p| p.errors.empty? }

    render :text => orden.to_a
  end
end
