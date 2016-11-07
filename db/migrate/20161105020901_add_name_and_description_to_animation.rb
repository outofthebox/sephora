class AddNameAndDescriptionToAnimation < ActiveRecord::Migration
  def change
    add_column :animations, :name, :string
    add_column :animations, :description, :string
  end
end
