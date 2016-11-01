class Banner < ActiveRecord::Base
  attr_accessor :image
  
  has_attached_file :image, {
    :styles => { :principal => "960x399>"},
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/productos/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  scope :prioritise, -> { order([:priority]) }
  scope :in_range, -> { where("DATE(valid_from) <= ? and DATE(valid_to) >= ?", Date.today, Date.today) }
end
