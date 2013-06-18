class AddColumsToRegistro < ActiveRecord::Migration
  def change
    add_column :registros, :tienda, :string
    add_column :registros, :qr, :boolean, :default => false
  end
end
