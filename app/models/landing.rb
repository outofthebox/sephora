class Landing < ActiveRecord::Base
  belongs_to :marca
  attr_accessible :marca_id, :link, :banner
  attr_accessor :banner

  has_attached_file :banner, {
    :styles => {:normal => "600x100>"},
    :default_url => "//s3.amazonaws.com/sephoramexico/marcas/banners/default_:style_producto.png"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

end
