class AddAttachmentImageToCarousel < ActiveRecord::Migration
  def self.up
    add_column :carousels, :image_file_name, :string
    add_column :carousels, :image_content_type, :string
    add_column :carousels, :image_file_size, :integer
    add_column :carousels, :image_updated_at, :datetime
  end

  def self.down
    remove_column :carousels, :image_file_name
    remove_column :carousels, :image_content_type
    remove_column :carousels, :image_file_size
    remove_column :carousels, :image_updated_at
  end
end
