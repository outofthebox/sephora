class CreateTiendas < ActiveRecord::Migration
  def self.up
    create_table :tiendas do |t|
      t.string :nombre
      t.string :slug
      t.string :horario
      t.string :contacto
      t.string :direccion
      t.string :mapa
      t.float :latitud
      t.float :longitud
      t.timestamps
    end
  end

  def self.down
    drop_table :tiendas
  end
end
