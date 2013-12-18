class BlogUser < ActiveRecord::Base
  attr_accessible :nickname, :nombre, :correo, :password, :fb_token, :tw_token, :tw_secret,:foto
  belongs_to :post
   has_attached_file :foto, {
    :styles => {
      :grande => ["150x15O#"],
      :chico => ["40x40#"]
    }
  }.merge(PAPERCLIP_STORAGE_OPTIONS)
end
