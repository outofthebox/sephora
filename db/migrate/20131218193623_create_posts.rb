class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string   "title"
      t.string   "slubtitle"
      t.string   "slug"
      t.text     "content"
      t.text     "extracto"
      t.integer  "visitas"
      t.integer  "categoria_id"
      t.timestamps
    end
  end
end
