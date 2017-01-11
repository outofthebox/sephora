class CreateAnimations < ActiveRecord::Migration
  def change
    create_table :animations do |t|
      t.date :valid_from
      t.date :valid_to
      t.string :header_to
      t.string :left_to
      t.string :right_to

      t.timestamps
    end
  end
end
