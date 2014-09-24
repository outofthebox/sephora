class CreateStoreEvents < ActiveRecord::Migration
  def self.down
    drop_table :store_events
  end

  def self.up
    create_table :store_events do |t|
      t.references :tienda
      t.references :event
      t.string :link
      t.string :dates

      t.timestamps
    end
    add_index :store_events, :tienda_id
    add_index :store_events, :event_id
  end
end
