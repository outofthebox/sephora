class AddColumnVistoToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :visto, :integer

  end
end
