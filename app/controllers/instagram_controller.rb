class InstagramController < ApplicationController
  def index
  	#@instagram = Instagram.user_recent_media(24459425, {:count => 8})
  	@instagram = Instagram.tag_recent_media("GiftmaniaSephora")
  	#puts @instagram;
  end

  def new_stuff
  end
end
