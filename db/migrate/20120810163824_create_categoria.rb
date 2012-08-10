class CreateCategoria < ActiveRecord::Migration
  def change
    create_table :categorias do |t|
      t.string :nombre
      t.string :slug
      t.boolean :visible
      t.integer :parent_id
      t.timestamps
    end
  end
end
