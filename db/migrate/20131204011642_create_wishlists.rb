class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists, :id => false do |t|
      t.integer :userwish_id
      t.integer :producto_id

      t.timestamps
    end
  end
end
