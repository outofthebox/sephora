class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :padre
      t.text :comentario
      t.boolean :publicado, :default => false
      t.integer :post_id

      t.timestamps
    end
  end
end
