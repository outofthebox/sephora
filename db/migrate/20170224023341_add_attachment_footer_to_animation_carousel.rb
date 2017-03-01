class AddAttachmentFooterToAnimationCarousel < ActiveRecord::Migration
  def self.up
    add_column :animation_carousels, :footer_file_name, :string
    add_column :animation_carousels, :footer_content_type, :string
    add_column :animation_carousels, :footer_file_size, :integer
    add_column :animation_carousels, :footer_updated_at, :datetime
  end

  def self.down
    remove_column :animation_carousels, :footer_file_name
    remove_column :animation_carousels, :footer_content_type
    remove_column :animation_carousels, :footer_file_size
    remove_column :animation_carousels, :footer_updated_at
  end
end
