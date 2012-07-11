class AddSlugToMarcasProductos < ActiveRecord::Migration
  def change
    add_column :marcas, :slug, :string 
    add_column :productos, :slug, :string
    add_index :marcas, :slug, :unique => true
    add_index :productos, :slug, :unique => true
  end
end
