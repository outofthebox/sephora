unless Rails.env.production?
  ENV['GOOGLE_ANALYTICS'] = ''

  ENV['SENDGRID_USERNAME'] = ''
  ENV['SENDGRID_PASSWORD'] = ''

  ENV['MAILCHIMP_API'] = ''
  ENV['MAILCHIMP_LIST_ID'] = ''

  ENV['S3_KEY'] = ''
  ENV['S3_SECRET'] = ''

  # set to anything to enable errors
  ENV['DEBUG'] = ''
end
