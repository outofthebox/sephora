class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists, :id => false do |t|
      t.belongs_to :producto
      t.belongs_to :usuario
      t.timestamps
    end
  end
end
