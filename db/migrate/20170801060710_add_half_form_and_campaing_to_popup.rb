class AddHalfFormAndCampaingToPopup < ActiveRecord::Migration
  def change
    add_column :popups, :half_form, :boolean
    add_column :popups, :campaing, :string
  end
end
