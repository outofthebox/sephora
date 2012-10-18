class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.integer :tienda
      t.string :nombre
      t.text :descripcion
      t.datetime :fecha
    end
  end
end
