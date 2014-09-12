class CreateStoreHasEvents < ActiveRecord::Migration
  def change
    create_table :store_has_events do |t|
      t.reference :tienda
      t.string :dates
      t.string :link

      t.timestamps
    end
  end
end
