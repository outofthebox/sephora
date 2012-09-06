class AddUrlslug < ActiveRecord::Migration
  def change
    add_column :categorias, :urlslug, :text
  end
end
