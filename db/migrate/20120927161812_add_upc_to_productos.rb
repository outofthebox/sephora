class AddUpcToProductos < ActiveRecord::Migration
  def change
    # agregamos upc
    add_column :productos, :upc, :string
    add_index :productos, :upc, :unique => true

    # quitamos el index de sku y lo agregamos de nuez
    remove_index :productos, :sku
    add_index :productos, :sku
  end
end
