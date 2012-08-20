class CreateSecciones < ActiveRecord::Migration
  def change
    create_table :secciones do |t|
      t.string :nombre
      t.string :slug
      t.text :descripcion
      t.boolean :visible
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end
  end
end
