class MediaTag < ActiveRecord::Base
  attr_accessible :instagram_id, :instagram_link, :thumb_url, :pic_url, :video_url, :fullname, :username, :approved
end
