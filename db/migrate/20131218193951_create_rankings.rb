class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :usuario_id
      t.integer :post_id
      t.integer :raiting

      t.timestamps
    end
  end
end
