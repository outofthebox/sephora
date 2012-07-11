class CreateMarcas < ActiveRecord::Migration
  def change
    create_table :marcas do |t|
      t.string :marca
      t.text :descripcion
      t.references :usuario
      t.timestamps
    end
  end
end
