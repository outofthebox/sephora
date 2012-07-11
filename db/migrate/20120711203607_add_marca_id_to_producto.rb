class AddMarcaIdToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :marca_id, :integer
    add_index :productos, :marca_id
  end
end
