class AddParentIdToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :parent_id, :integer
  end
end
