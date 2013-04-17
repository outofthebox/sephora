unless Rails.env.production?
  ENV['GOOGLE_ANALYTICS'] = ''

  ENV['SENDGRID_USERNAME'] = ''
  ENV['SENDGRID_PASSWORD'] = ''

  ENV['MAILCHIMP_API'] = ''
  ENV['MAILCHIMP_LIST_ID'] = ''

  ENV['S3_KEY'] = 'AKIAINXYHER7TJ3FDRBA'
  ENV['S3_SECRET'] = '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'

  ENV['U'] = ''
  ENV['P'] = ''

  # set to anything to enable errors
  ENV['DEBUG'] = ''
end
