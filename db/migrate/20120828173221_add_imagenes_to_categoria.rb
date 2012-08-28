class AddImagenesToCategoria < ActiveRecord::Migration
  def change
    add_column :categorias, :cover_file_name, :string
    add_column :categorias, :cover_content_type, :string
    add_column :categorias, :cover_file_size, :integer
    add_column :categorias, :cover_updated_at, :datetime
  end
end
