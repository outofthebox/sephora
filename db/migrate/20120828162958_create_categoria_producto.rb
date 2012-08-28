class CreateCategoriaProducto < ActiveRecord::Migration
  def change
    create_table :categoria_productos do |t|
      t.references :producto
      t.references :categoria
      t.integer :orden
      t.text :descripcion

      t.timestamps
    end
    
    add_index :categoria_productos, :producto_id
    add_index :categoria_productos, :categoria_id
  end
end
