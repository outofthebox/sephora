class Animation < ActiveRecord::Base
	attr_accessor :header, :left, :right, :logo
  
  has_attached_file :header, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_header.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :left, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_left.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :right, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_right.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :hot_now, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_hot_now.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :sephora_picks, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_sephora_picks.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :must_have, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_must_have.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  has_attached_file :logo, {
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/animaciones/default_:style_logo.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)


  validates :header, presence: true
  #validates :left, presence: true
  #validates :right, presence: true

  scope :in_range, -> { where("DATE(valid_from) <= ? and DATE(valid_to) >= ?", Date.today, Date.today) }
end
