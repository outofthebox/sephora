class AddAttachmentHeaderToAnimationCarousel < ActiveRecord::Migration
  def self.up
    add_column :animation_carousels, :header_file_name, :string
    add_column :animation_carousels, :header_content_type, :string
    add_column :animation_carousels, :header_file_size, :integer
    add_column :animation_carousels, :header_updated_at, :datetime
  end

  def self.down
    remove_column :animation_carousels, :header_file_name
    remove_column :animation_carousels, :header_content_type
    remove_column :animation_carousels, :header_file_size
    remove_column :animation_carousels, :header_updated_at
  end
end
