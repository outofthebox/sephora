class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :products
      t.integer :animation_carousel_id

      t.timestamps
    end
  end
end
