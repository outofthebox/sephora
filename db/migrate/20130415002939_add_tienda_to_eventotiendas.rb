class AddTiendaToEventotiendas < ActiveRecord::Migration
  def change
    add_column :eventotiendas, :tienda_id, :integer

  end
end
