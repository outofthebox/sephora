unless Rails.env.production?
  ENV['GOOGLE_ANALYTICS'] = ''
  ENV['SENDGRID_USERNAME'] = ''
  ENV['SENDGRID_PASSWORD'] = ''
  ENV['MAILCHIMP_API'] = ''
  ENV['MAILCHIMP_LIST_ID'] = ''
end
