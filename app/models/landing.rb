class Landing < ActiveRecord::Base
	belongs_to :marca
	attr_accessible :marca_id, :link, :banner
  attr_accessor :banner

	has_attached_file :banner, {
    :styles => {:normal => "600x100>"}
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

end
