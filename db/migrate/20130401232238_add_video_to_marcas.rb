class AddVideoToMarcas < ActiveRecord::Migration
  def change
    add_column :marcas, :video, :string

  end
end
