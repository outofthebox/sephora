class AddLinkToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :link, :string

  end
end
