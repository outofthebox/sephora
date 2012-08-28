class AddImagenesToMarca < ActiveRecord::Migration
  def change
    add_column :marcas, :logo_file_name, :string
    add_column :marcas, :logo_content_type, :string
    add_column :marcas, :logo_file_size, :integer
    add_column :marcas, :logo_updated_at, :datetime

    add_column :marcas, :promo_file_name, :string
    add_column :marcas, :promo_content_type, :string
    add_column :marcas, :promo_file_size, :integer
    add_column :marcas, :promo_updated_at, :datetime
  end
end
