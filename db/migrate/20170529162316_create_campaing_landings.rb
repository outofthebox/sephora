class CreateCampaingLandings < ActiveRecord::Migration
  def change
    create_table :campaing_landings do |t|
      t.string :campaing_name
      t.string :vanity_url
      t.string :redirect_url

      t.timestamps
    end
  end
end
