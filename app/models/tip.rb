class Tip < ActiveRecord::Base
	has_attached_file :foto, {
    :styles => {
      :small => ["230x250>"],
      :medium => ["550X590"]
    }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)
	def to_param
	"#{id}-#{slug}"
	end
end
