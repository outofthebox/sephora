class Popup < ActiveRecord::Base
  attr_accessor :image

  POPUP_TYPES = %w(one_attribute two_attributes three_attributes four_attributes five_attributes)

  validates :popup_type, presence: true, inclusion: { in: POPUP_TYPES, message: "is not a valid popup type" }
  validates :image, presence: true
  
  has_attached_file :image, {
    :styles => { :one_attribute => "720x560>" },
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/popups/default_:style_popup.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  scope :in_range, -> { where("DATE(valid_from) <= ? and DATE(valid_to) >= ?", Date.today, Date.today) }

end

