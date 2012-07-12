unless Rails.env.production?
  ENV['GOOGLE_ANALYTICS'] = ''
  ENV['SENDGRID_USERNAME'] = ''
  ENV['SENDGRID_PASSWORD'] = ''
end
