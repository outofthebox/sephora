class AddPromotionDiscountToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :descuento_porcentual, :integer, :default => 0

  end
end
