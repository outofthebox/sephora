class CampaingLanding < ActiveRecord::Base
	validates :image, presence: true
	validates :vanity_url, presence: true, uniqueness: true

	has_attached_file :image, {
    :styles => { principal: "960x" },
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/landings/default_:style_campaing_landing.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)
end
