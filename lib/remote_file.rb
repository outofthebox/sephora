require 'faraday'
require 'uri'

class RemoteFile
  class_attribute :request
  
	def initialize(url)
	 	i = URI(url)

    scheme = i.scheme
    host = i.host
    path = i.path rescue '/'
    query = i.query rescue '' 

    host_path = "#{scheme}://#{host}"
    full_path = "#{scheme}://#{host}#{path}#{query}"

    conn = Faraday.new(:url => host_path) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    request = conn.get do |req|
      req.url "#{path}#{query}"
      req.headers['Accept'] = 'application/csv'
    end

    self.request = request
	end
end