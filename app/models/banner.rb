class Banner < ActiveRecord::Base
  attr_accessor :image

  BANNER_TYPES = %w(principal producto mini_izquierdo mini_derecho wishlist callcenter)

  validates :banner_type, presence: true, inclusion: { in: BANNER_TYPES, message: "is not a valid banner type" }

  scope :principal, -> { where(banner_type: "principal") }
  scope :producto, -> { where(banner_type: "producto") }
  scope :mini_izquierdo, -> { where(banner_type: "mini_izquierdo") }
  scope :mini_derecho, -> { where(banner_type: "mini_derecho") }
  scope :wishlist, -> { where(banner_type: "wishlist") }
  scope :callcenter, -> { where(banner_type: "callcenter") }

  has_attached_file :image, {
    :styles => { :principal => "960x399>", mini: "431x249>", producto: "300x117>", wishlist: "960x", callcenter: "960x" },
    :default_url => "//s3.amazonaws.com/sephoramexico/estatico/productos/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  scope :prioritise, -> { order([:priority]) }
  scope :in_range, -> { where("DATE(valid_from) <= ? and DATE(valid_to) >= ?", Date.today, Date.today) }

  def self.get_mini_izquierdo
  	banners = self.mini_izquierdo.in_range
  	return banners.first if banners.present?
  end

  def self.get_mini_derecho
  	banners = self.mini_derecho.in_range
  	return banners.first if banners.present?
  end

  def self.get_banner_producto
  	banners = self.producto.in_range
  	return banners.first if banners.present?
  end

  def self.get_banner_wishlist
    banners = self.wishlist.in_range
    return banners.first if banners.present?
  end

  def self.get_banner_callcenter
    banners = self.callcenter.in_range
    return banners.first if banners.present?
  end
end
