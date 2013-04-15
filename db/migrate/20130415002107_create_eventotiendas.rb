class CreateEventotiendas < ActiveRecord::Migration
  def self.up
    create_table :eventotiendas do |t|
      t.string :nombre
      t.text :horario
      t.text :descripcion
      t.text :informacion
      t.timestamps
    end
  end

  def self.down
    drop_table :eventotiendas
  end
end
