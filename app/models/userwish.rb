class Userwish < ActiveRecord::Base
	has_and_belongs_to_many :products
	attr_accessible :name, :provider, :id, :post_id
end
