class AddAttachmentFotoToBlogUser < ActiveRecord::Migration
  def self.up
    add_column :blog_users, :foto_file_name, :string
    add_column :blog_users, :foto_content_type, :string
    add_column :blog_users, :foto_file_size, :integer
    add_column :blog_users, :foto_updated_at, :datetime
  end

  def self.down
    remove_column :blog_users, :foto_file_name
    remove_column :blog_users, :foto_content_type
    remove_column :blog_users, :foto_file_size
    remove_column :blog_users, :foto_updated_at
  end
end
