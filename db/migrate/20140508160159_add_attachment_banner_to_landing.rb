class AddAttachmentBannerToLanding < ActiveRecord::Migration
  def self.up
    add_column :landings, :banner_file_name, :string
    add_column :landings, :banner_content_type, :string
    add_column :landings, :banner_file_size, :integer
    add_column :landings, :banner_updated_at, :datetime
  end

  def self.down
    remove_column :landings, :banner_file_name
    remove_column :landings, :banner_content_type
    remove_column :landings, :banner_file_size
    remove_column :landings, :banner_updated_at
  end
end
