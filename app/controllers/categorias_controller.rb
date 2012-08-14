class CategoriasController < ApplicationController
  def ver
    @categoria = Categoria.by_slug(params[:categoria]).first
  end
end
