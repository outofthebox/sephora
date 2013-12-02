class CreateUserwishes < ActiveRecord::Migration
  def change
    create_table :userwishes do |t|
      t.string :provider
      t.string :uid
      t.string :name

      t.timestamps
    end
  end
end
