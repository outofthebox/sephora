class CreatePostFavs < ActiveRecord::Migration
  def change
    create_table :post_favs do |t|
      t.integer :usuario_id
      t.integer :post_id

      t.timestamps
    end
  end
end
