class AddAttachmentImageToCampaingLandings < ActiveRecord::Migration
  def self.up
    add_column :campaing_landings, :image_file_name, :string
    add_column :campaing_landings, :image_content_type, :string
    add_column :campaing_landings, :image_file_size, :integer
    add_column :campaing_landings, :image_updated_at, :datetime
  end

  def self.down
    remove_column :campaing_landings, :image_file_name
    remove_column :campaing_landings, :image_content_type
    remove_column :campaing_landings, :image_file_size
    remove_column :campaing_landings, :image_updated_at
  end
end
