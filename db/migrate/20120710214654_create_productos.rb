class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :nombre
      t.text :descripcion
      t.decimal :precio, :precision => 10, :scale => 2
      t.boolean :publicado, :default => true
      t.text :ingredientes
      t.text :usos
      t.references :usuario

      t.timestamps
    end
  end
end
