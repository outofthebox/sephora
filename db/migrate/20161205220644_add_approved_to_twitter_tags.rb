class AddApprovedToTwitterTags < ActiveRecord::Migration
  def change
    add_column :twitter_tags, :approved, :boolean, default: :false
  end
end
