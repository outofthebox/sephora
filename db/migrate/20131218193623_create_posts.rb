class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string   :title
      t.string   :subtitle
      t.string   :slug
      t.text     :content
      t.text     :extracto
      t.integer  :visitas
      t.integer  :categoria_id
      t.boolean  :publicado, :default => true
      t.timestamps
    end
  end
end
