class Sephoragram < ActiveRecord::Base
	attr_accessible :instagram_id, :instagram_link, :pic_large, :pic_med, :pic_thumb, :username, :publicado, :fullname
end
