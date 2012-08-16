class AddNestedFieldsToCategorias < ActiveRecord::Migration
  def change
    add_column :categorias, :lft, :integer
    add_column :categorias, :rgt, :integer
    add_column :categorias, :depth, :integer
  end
end
