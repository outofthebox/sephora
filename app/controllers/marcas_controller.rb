require "csv"

class MarcasController < ApplicationController
  before_filter :set_marca, :only => [:incrementar_vistas, :show]
  before_filter :incrementar_vistas, :only => [:show]
  before_filter :get_parent_categories, :only => [:show]

  def index
    @marcas = Marca.all
    authorize! :manage, @marca
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
    @careoca_makeup = Producto.where(:upc => ["3378872080497","3378872080473", "3378872080572","3378872080442"])
    @careoca_bath = Producto.where(:upc => ["3378872079781", "3378872079743", "3378872079750", "3378872079767"])
    f_cat = []
    @f_parent = []

    pic = Producto.includes(:categoria).where(:marca_id => @marca.id).where(:publicado => true);
    pic.each do |t| f_cat << t.categoria.nombre rescue nil end
    @categorias = f_cat.uniq.sort

    @parent_categories.each do |pc|
      child_cats = Categoria.where(:parent_id => pc.id).pluck(:id) rescue []
      child_cats << pc.id
      p_count = pic.where(:categoria_id => child_cats).where(:parent_id => nil).count
      @f_parent << {:id => pc.id, :categoria => pc.nombre, :product_count => p_count, :slug => pc.slug}
    end
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


  def export_to_csv
    if params[:pass] == "outofthebox14"
      respond_to do |format|
        format.html
        format.csv { render text: Marca.to_csv}
      end
    end
  end

  private

  def incrementar_vistas
    vista = @marca.vista || 0
    vista += 1
    @marca.update_attribute(:vista, vista)
  end

  def set_marca
    @marca = Marca.includes(:marca_producto, :featured).where(:slug => params[:slug]).first
  end

  def get_parent_categories
    @parent_categories = Categoria.where(:parent_id => nil)
  end
end
