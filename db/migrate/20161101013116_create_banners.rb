class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.boolean :pinned
      t.date :valid_from
      t.date :valid_to
      t.integer :priority

      t.timestamps
    end
  end
end
