class CreateAnimationCarousels < ActiveRecord::Migration
  def change
    create_table :animation_carousels do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
