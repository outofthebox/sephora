class ContactoMailer < ActionMailer::Base
  include SendGrid
  default from: "sephora@outofthebox.mx"
  sendgrid_category :use_subject_lines
  sendgrid_enable :ganalytics, :opentrack

  def contacto(email, body)
    mail :to => "sephora@outofthebox.mx",
          :from => email,
          :subject => 'Contacto',
          :body => body
  end
end
