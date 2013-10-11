# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sephora::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => 587,
  :domain => "oob.mx",
  :authentication => :plain,
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :enable_starttls_auto => true
}