Rack::Attack.blacklist('block 72.14.186.108') do |req|
  # Requests are blocked if the return value is truthy
  '72.14.186.108' == req.ip
end
