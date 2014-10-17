class AddLinkToTiendas < ActiveRecord::Migration
  def change
    add_column :tiendas, :map, :string

  end
end
