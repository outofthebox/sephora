class AddTokenToUserwishes < ActiveRecord::Migration
  def change
    add_column :userwishes, :access_token, :string

  end
end
