# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)


use Rack::Block do
  bot_access do
		path '/error' do
    	halt 404
    end
  end
end

run Sephora::Application
