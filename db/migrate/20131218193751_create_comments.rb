class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :padre
      t.text :comentario
      t.boolean :publicado, :default => false

      t.timestamps
    end
  end
end
