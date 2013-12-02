class CreateWishProductJoin < ActiveRecord::Migration
  def up
  		create_table "userwishes_products", :id => false do |t|
  			t.column 'userwish_id', :integer
  			t.column 'product_id', :integer
  		end
  end

  def down
  	drop_table "userwishes_products"
  end
end
