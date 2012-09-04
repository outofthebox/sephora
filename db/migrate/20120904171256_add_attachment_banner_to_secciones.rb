class AddAttachmentBannerToSecciones < ActiveRecord::Migration
  def change
    add_column :secciones, :cover_file_name, :string
    add_column :secciones, :cover_content_type, :string
    add_column :secciones, :cover_file_size, :integer
    add_column :secciones, :cover_updated_at, :datetime
  end
end
