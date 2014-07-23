class AddDescuentoToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :descuento, :decimal

  end
end
