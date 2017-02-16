class CreatePopups < ActiveRecord::Migration
  def change
    create_table :popups do |t|
      t.boolean :popup_type
      t.boolean :name
      t.boolean :email
      t.boolean :dob
      t.boolean :store
      t.date :valid_from
      t.date :valid_to

      t.timestamps
    end
  end
end
