class AddDescripcionToCategorias < ActiveRecord::Migration
  def change
    add_column :categorias, :descripcion, :text
  end
end
