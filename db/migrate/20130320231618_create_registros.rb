class CreateRegistros < ActiveRecord::Migration
  def change
    create_table :registros do |t|
      t.string :nombre
      t.string :email
      t.string :cp

      t.timestamps
    end
  end
end
