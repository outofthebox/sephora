class AddBehindthebrandToMarcas < ActiveRecord::Migration
  def change
    add_column :marcas, :behindthebrand, :text
  end
end
