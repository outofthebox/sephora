class InstagramController < ApplicationController
  def index
  	@instagram = Instagram.tag_recent_media("GiftmaniaSephora", {:count => 8})
  end

  def new_stuff
  end
end
