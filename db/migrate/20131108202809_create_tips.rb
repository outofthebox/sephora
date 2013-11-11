class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :nombre
      t.string :correo
      t.text :tip

      t.timestamps
    end
  end
end
