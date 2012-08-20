class CategoriasRebuild < ActiveRecord::Migration
  def up
    Categoria.rebuild!
  end
end
