class CreateLandings < ActiveRecord::Migration
  def change
    create_table :landings do |t|
      t.integer :marca_id
      t.string :link

      t.timestamps
    end
  end
end
