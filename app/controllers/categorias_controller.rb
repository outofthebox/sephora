class CategoriasController < ApplicationController
  def index
    @categorias = Categoria.all
  end

  def ver
    @categoria = Categoria.by_slug(params[:categoria]).first
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
