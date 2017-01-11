class AddAttachmentHeaderToAnimation < ActiveRecord::Migration
  def self.up
    add_column :animations, :header_file_name, :string
    add_column :animations, :header_content_type, :string
    add_column :animations, :header_file_size, :integer
    add_column :animations, :header_updated_at, :datetime
  end

  def self.down
    remove_column :animations, :header_file_name
    remove_column :animations, :header_content_type
    remove_column :animations, :header_file_size
    remove_column :animations, :header_updated_at
  end
end
