class StoreHasEvent < ActiveRecord::Base
	has_and_belongs_to_many :events
	has_and_belongs_to_many :tienda	
	attr_accessible :id, :tienda_id,  :link, :dates, :event_id
end
