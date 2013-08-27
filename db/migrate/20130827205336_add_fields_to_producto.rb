class AddFieldsToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :image_code, :string

    add_column :productos, :personalidad, :string

  end
end
