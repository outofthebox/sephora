class AddColumnsToUserwishes < ActiveRecord::Migration
  def change
    add_column :userwishes, :post_id, :string

  end
end
