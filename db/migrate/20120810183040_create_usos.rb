class CreateUsos < ActiveRecord::Migration
  def change
    create_table :usos do |t|
      t.string :nombre
      t.string :slug
      t.boolean :visible
      t.timestamps
    end
  end
end
