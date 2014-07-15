class AddViewsToMarca < ActiveRecord::Migration
  def change
    add_column :marcas, :vista, :integer

  end
end
