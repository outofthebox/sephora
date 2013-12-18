class CreateBlogUsers < ActiveRecord::Migration
  def change
    create_table :blog_users do |t|
      t.string :nickname 
      t.string :nombre
      t.string :correo
      t.string :password, :limit => 10000
      t.text :fb_token
      t.text :tw_token
      t.text :tw_secret

      t.timestamps
    end
  end
end
