class AddDescripcionToCategorias < ActiveRecord::Migration
  def change
    add_column :categorias, :descripcion, :text, :default => 0
  end
end
