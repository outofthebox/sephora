class AddBannerTypeToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :banner_type, :string, default: "principal"
  end
end
