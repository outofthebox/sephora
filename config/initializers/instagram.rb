require "instagram"

Instagram.configure do |config|
	config.client_id =	ENV['insta_client_id'];
	config.client_secret = ENV['insta_client_secret'];
end
