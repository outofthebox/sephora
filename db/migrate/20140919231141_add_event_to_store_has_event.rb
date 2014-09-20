class AddEventToStoreHasEvent < ActiveRecord::Migration
  def change
    add_column :store_has_events, :event_id, :integer

  end
end
