class AddSapCodeToProducts < ActiveRecord::Migration
  def change
    add_column :productos, :sap, :string

  end
end
