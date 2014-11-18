class CreateRedemptions < ActiveRecord::Migration
  def change
    create_table :redemptions do |t|
      t.string :code
      t.integer :count

      t.timestamps
    end
  end
end
