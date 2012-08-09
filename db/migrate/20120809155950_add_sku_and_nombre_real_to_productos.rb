class AddSkuAndNombreRealToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :sku, :string
    add_column :productos, :nombre_real, :text

    add_index :productos, :sku, :unique => true
  end
end
