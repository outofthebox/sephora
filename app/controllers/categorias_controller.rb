class CategoriasController < ApplicationController
  def index
    @categorias = Categoria.arrange
  end

  def ver
    @marcas_seleccionadas = params[:marca].split(",").map{|m| m.to_i } unless params[:marca].nil?
    @categoria = Categoria.includes(:productos).by_slug(params[:categoria]).first
    subcategorias = @categoria.descendants
    @subcategorias = subcategorias.reject{|r| r.parent_id != @categoria.id }
    # para encontrar productos en categorías descendientes
    catmap = [@categoria.id] + @subcategorias.map{|s| s.id }
    @marcas_para_categoria = Categoria.encontrar_marcas(catmap)
    if params[:marca].blank?
      @productos = Producto.joins(:marca).publicados.padres.where(:categoria_id => catmap).order(("marcas.marca ASC"  if params[:ordenar] == "marca")).order(preciorder(params[:precio])).order('foto_file_name ASC').page(params[:page]).per(perparams(params[:ver]))
      @productoscount = Producto.publicados.padres.where(:categoria_id => catmap).order(preciorder(params[:precio])).count
    else
      @marca = Marca.find(@marcas_seleccionadas)
      @productos = Producto.publicados.padres.where(:marca_id => @marca.map{|m| m.id }, :categoria_id => catmap).order(preciorder(params[:precio])).page(params[:page]).per(perparams(params[:ver]))
      @productoscount = Producto.publicados.padres.where(:marca_id => @marca.map{|m| m.id }, :categoria_id => catmap).count
    end
  end

  def show
    @categoria = Categoria.find params[:id]
    render :ver
  end

  def new
    @categoria = Categoria.new
  end

  def create
    @categoria = Categoria.new params[:categoria]
    if @categoria.valid?
      @categoria.save
      redirect_to edit_categoria_path(@categoria)
    else
      render :new
    end
  end

  def edit
    @categoria = Categoria.includes(:productos).find params[:id]
    authorize! :manage, @categoria
  end

  def update
    @categoria = Categoria.find params[:id]
    authorize! :manage, @categoria
    @categoria.update_attributes params[:categoria]
    if @categoria.save
      redirect_to edit_categoria_path(@categoria)
    else
      render :edit
    end
  end

  # Vínculos

  def vincular
    categoria = Categoria.find params[:id]
    authorize! :manage, categoria
    vinculo = categoria.categoria_producto.build params[:categoria_producto]
    if vinculo.valid?
      vinculo.save
    end
    redirect_to edit_categoria_path(categoria.id)
  end

  def desvincular
    categoria = Categoria.find params[:id]
    authorize! :manage, categoria
    categoria_producto = categoria.categoria_producto.find params[:categoria_producto]

    if check_minihash(categoria_producto, params[:hash])
      categoria_producto.destroy
    end

    redirect_to edit_categoria_path(categoria.id)
  end

  def producto_editar
    @categoria = Categoria.find params[:id]
    authorize! :manage, @categoria
    @categoria_producto = @categoria.categoria_producto.find params[:v_id]
  end

  def producto_update
    categoria = Categoria.find params[:id]
    authorize! :manage, categoria
    categoria_producto = categoria.categoria_producto.find(params[:v_id])
    categoria_producto.update_attributes params[:categoria_producto]
    if categoria_producto.valid?
      categoria_producto.save
      redirect_to categoria_editar_producto_path(categoria.id, categoria_producto.id)
    else
      render :producto_editar
    end
  end

  def actualizar_orden
    vinculos = params[:vinculo_id]
    orden = (0...vinculos.size)

    CategoriaProducto.update( vinculos, orden.map{|o| { :orden => o }}).reject { |p| p.errors.empty? }

    render :text => orden.to_a
  end
end
