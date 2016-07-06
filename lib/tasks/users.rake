require 'mailgun'

namespace :usuarios do
  task :obtener_usuarios => :environment do
    #AWS S3 SETUP
    bucket_name = "sephoramexico"
    temp_file = Tempfile.new("todos_#{Date.today.to_s}")
    key_path = "usuarios/"+File.basename(temp_file)+".csv"
    s3 = AWS::S3.new

    @usuarios = Usuario.order("created_at DESC")

    CSV.open(temp_file, "w") do |csv|  
      csv << Usuario.attribute_names
      @usuarios.each do |u|
        csv << u.attributes.values
      end
    end

    s3.buckets[bucket_name].objects[key_path].write(:file => temp_file.path, :acl => :public_read)
    url_for_read = s3.buckets[bucket_name].objects[key_path].url_for(:read) rescue "/"
    url_for_download = url_for_read.to_s.split("?")[0] rescue url_for_read

    # First, instantiate the Mailgun Client with your API key
    mg_client = Mailgun::Client.new ENV['MAILGUN_SECRET_KEY']

    # Define your message parameters
    message_params =  {
      from: 'Scarlett Gallardo <scarlett@gessgallardo.com>',
      to: 'Ana Valeria <valeria@outofthebox.mx>',
      subject: "Lista de usuarios sephora",
      html: "Descarga la lista de usuarios desde <a href='#{url_for_download}'>aqui</a>",
      text: "Descarga la lista de usuarios desde aqui #{url_for_download}"
    }

    #Send your message through the client
    mg_client.send_message 'gessgallardo.com', message_params
  end
end