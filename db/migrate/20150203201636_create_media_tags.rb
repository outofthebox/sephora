class CreateMediaTags < ActiveRecord::Migration
  def change
    create_table :media_tags do |t|
      t.string :instagram_id
      t.string :instagram_link
      t.string :thumb_url
      t.string :pic_url
      t.string :video_url
      t.string :fullname
      t.string :username
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
