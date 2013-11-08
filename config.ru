# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)


use Rack::Block do
	ua_pattern /Baiduspider/i do
		halt 500
	end
end

run Sephora::Application
