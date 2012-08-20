class CreateProductoSecciones < ActiveRecord::Migration
  def change
    create_table :producto_secciones do |t|
      t.references :producto
      t.references :seccion
      t.integer :orden
      t.text :descripcion

      t.timestamps
    end
    
    add_index :producto_secciones, :producto_id
    add_index :producto_secciones, :seccion_id
  end
end
