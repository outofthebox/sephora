class Userwish < ActiveRecord::Base
	validate :name, presence: true, uniqueness: true
	belongs_to :wishlist
	attr_accessor :name, :provider, :id, :post_id, :uid, :access_token
end
