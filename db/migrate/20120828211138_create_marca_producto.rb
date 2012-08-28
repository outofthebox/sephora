class CreateMarcaProducto < ActiveRecord::Migration
  def change
    create_table :marca_productos do |t|
      t.references :producto
      t.references :marca
      t.integer :orden
      t.text :descripcion

      t.timestamps
    end
    
    add_index :marca_productos, :producto_id
    add_index :marca_productos, :marca_id
  end
end
