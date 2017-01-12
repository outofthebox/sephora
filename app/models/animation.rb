class Animation < ActiveRecord::Base
	attr_accessor :header, :left, :right
  
  has_attached_file :header, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :left, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :right, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :hot_now, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :sephora_picks, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :must_have, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)


  validates :header, presence: true
  validates :left, presence: true
  validates :right, presence: true

  scope :in_range, -> { where("DATE(valid_from) <= ? and DATE(valid_to) >= ?", Date.today, Date.today) }
end
