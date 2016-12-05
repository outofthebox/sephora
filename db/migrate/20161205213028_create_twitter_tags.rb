class CreateTwitterTags < ActiveRecord::Migration
  def change
    create_table :twitter_tags do |t|
      t.string :tweet_id
      t.string :media_url
      t.string :tweet_url
      t.timestamps null: false
    end
  end
end
