class AddAttachmentLeftToAnimation < ActiveRecord::Migration
  def self.up
    add_column :animations, :left_file_name, :string
    add_column :animations, :left_content_type, :string
    add_column :animations, :left_file_size, :integer
    add_column :animations, :left_updated_at, :datetime
  end

  def self.down
    remove_column :animations, :left_file_name
    remove_column :animations, :left_content_type
    remove_column :animations, :left_file_size
    remove_column :animations, :left_updated_at
  end
end
