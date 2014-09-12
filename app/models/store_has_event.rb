class StoreHasEvent < ActiveRecord::Base
	has_many :tiendas
	
	attr_accessible :id, :link, :dates, :tiendas

end
