class StoreEvent < ActiveRecord::Base
  belongs_to :tienda
  belongs_to :event
  has_one :event
  has_many :tienda
  attr_accessor :link, :dates, :tienda_id, :event_id
end
