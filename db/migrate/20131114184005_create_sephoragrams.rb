class CreateSephoragrams < ActiveRecord::Migration
  def change
    create_table :sephoragrams do |t|
      t.string :instagram_id
      t.string :instagram_link
      t.string :pic_thumb
      t.string :pic_med
      t.string :pic_large
      t.string :fullname
      t.string :username
      t.boolean :publicado, :default => false
      t.timestamps
    end
  end
end
