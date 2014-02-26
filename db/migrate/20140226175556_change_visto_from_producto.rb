class ChangeVistoFromProducto < ActiveRecord::Migration
  def up
  	change_column :productos, :visto,  :integer, :default => 0
  end

  def down
  end
end
