class CreateAnimations < ActiveRecord::Migration
  def change
    create_table :animations do |t|
      t.string :head_banner_link
      t.date :valid_from
      t.date :valid_to

      t.timestamps
    end
  end
end
