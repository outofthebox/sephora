class AddAttachmentFotoToTienda < ActiveRecord::Migration
  def self.up
    unless column_exists? :tiendas, :foto_file_name
      add_column :tiendas, :foto_file_name, :string
      add_column :tiendas, :foto_content_type, :string
      add_column :tiendas, :foto_file_size, :integer
      add_column :tiendas, :foto_updated_at, :datetime
    end
  end

  def self.down
    remove_column :tiendas, :foto_file_name
    remove_column :tiendas, :foto_content_type
    remove_column :tiendas, :foto_file_size
    remove_column :tiendas, :foto_updated_at
  end
end
