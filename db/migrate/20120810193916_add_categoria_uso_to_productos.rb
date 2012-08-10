class AddCategoriaUsoToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :categoria_id, :integer
    add_column :productos, :uso_id, :integer

    add_index :productos, :categoria_id
    add_index :productos, :uso_id
  end
end
