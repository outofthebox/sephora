class CreatePopups < ActiveRecord::Migration
  def change
    create_table :popups do |t|
      t.string :popup_type, default: "one_attribute"
      t.boolean :name, default: false
      t.boolean :email, default: true
      t.boolean :dob, default: false
      t.boolean :store, default: false
      t.date :valid_from
      t.date :valid_to

      t.timestamps
    end
  end
end
