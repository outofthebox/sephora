class Event < ActiveRecord::Base
		has_many :store_events, dependent: :destroy
	  attr_accessible :id, :title, :description, :photo
		attr_accessor :photo
		
	  has_attached_file :photo, {
    :styles => { :grande => "450x450#", :normal => "162x162>", :mediano => "262x262>", :chico => "62x62>" },
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/events/default_:style_event.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)
end
