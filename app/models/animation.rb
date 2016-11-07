class Animation < ActiveRecord::Base
  attr_accessor :banner_left 
  attr_accessor :banner_right
  attr_accessor :banner_head
  
  has_attached_file :banner_head, {
    :styles => { :principal => "1920x70>"},
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/productos/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :banner_left, {
    :styles => { :principal => "250x2327>"},
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/productos/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :banner_right, {
    :styles => { :principal => "250x2327>"},
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/productos/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  scope :in_range, -> { where("DATE(valid_from) <= ? and DATE(valid_to) >= ?", Date.today, Date.today) }
end
