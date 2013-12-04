class Userwish < ActiveRecord::Base
	belongs_to :wishlist
	attr_accessible :name, :provider, :id, :post_id, :uid
end
