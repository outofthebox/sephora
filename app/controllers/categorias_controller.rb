class CategoriasController < ApplicationController
  def index
    @categorias = Categoria.arrange
  end

  def ver
    @categoria = Categoria.by_slug(params[:categoria]).first
    subcategorias = @categoria.descendants
    @subcategorias = subcategorias.reject{|r| r.parent_id != @categoria.id }

    # para encontrar productos en categorías descendientes
    @productos = Producto.publicados.where :categoria_id => [@categoria.id] + @subcategorias.map{|s| s.id }
  end

  def show
    @categoria = Categoria.find params[:id]
    render :ver
  end

  def edit
    @categoria = Categoria.find params[:id]
  end

  def update
    @categoria = Categoria.find params[:id]
    @categoria.update_attributes params[:categoria]
    if @categoria.save
      redirect_to edit_categoria_path(@categoria)
    else
      render :edit
    end
  end
end
