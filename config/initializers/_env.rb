unless Rails.env.production?
  ENV['GOOGLE_ANALYTICS'] = ''

  ENV['SENDGRID_USERNAME'] = 'outofthebox'
  ENV['SENDGRID_PASSWORD'] = 'oob2k12send'

  ENV['MAILCHIMP_API'] = '28d71bfcdecbc9affb80caf3da631e2f-us2'
  ENV['MAILCHIMP_LIST_ID'] = '50fc66a89c'

  ENV['S3_KEY'] = 'AKIAINXYHER7TJ3FDRBA'
  ENV['S3_SECRET'] = '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'
  ENV['AWS_ACCESS_KEY_ID'] = 'AKIAINXYHER7TJ3FDRBA'
  ENV['AWS_SECRET_ACCESS_KEY'] = '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'

  ENV['MAILGUN_SECRET_KEY'] = 'key-c30a13dbaa0c542ed6b5e58a6eb09961'

  ENV['U'] = '123'
  ENV['P'] = '123'

  # set to anything to enable errors
  ENV['DEBUG'] = ''
end
