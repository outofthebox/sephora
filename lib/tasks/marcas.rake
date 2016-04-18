namespace :marcas do
  task :info => :environment do
    #AWS S3 SETUP
    bucket_name = "sephoramexico"
    temp_file = Tempfile.new("info_#{Date.today.to_s}")
    key_path = "marcas/"+File.basename(temp_file)+".csv"
    s3 = AWS::S3.new

    CSV.open(temp_file, "w") do |csv|
      marcas = Marca.all
      csv << ["nombre", "descripcion", "logo", "promo"]
      marcas.each do |m|
        marca_name = m.marca.marca rescue ""
        csv << [m.marca, m.descripcion, m.logo.to_s, m.promo.to_s]
      end
    end

    s3.buckets[bucket_name].objects[key_path].write(:file => temp_file.path, :acl => :public_read)
    url_for_read = s3.buckets[bucket_name].objects[key_path].url_for(:read) rescue "/"

    puts "Uploading file #{temp_file.path} to bucket #{bucket_name}."
    puts "Download from: #{url_for_read}"

    template_email({
      link: url_for_read,
      message: "Esta es la lista de informacion de marca, los podras encontrar en el siguiente link",
      title: "Resumen de marcas en el sitio"
    })
  end

  task :todas => :environment do
    #AWS S3 SETUP
    bucket_name = "sephoramexico"
    temp_file = Tempfile.new("todos_#{Date.today.to_s}")
    key_path = "marcas/"+File.basename(temp_file)+".csv"
    s3 = AWS::S3.new

    CSV.open(temp_file, "w") do |csv|
      marcas = Marca.all
      csv << Marca.new.attributes.keys
      marcas.each do |p|
        marca_name = p.marca.marca rescue ""
        csv << p.attributes.values
      end
    end

    s3.buckets[bucket_name].objects[key_path].write(:file => temp_file.path, :acl => :public_read)
    url_for_read = s3.buckets[bucket_name].objects[key_path].url_for(:read) rescue "/"

    puts "Uploading file #{temp_file.path} to bucket #{bucket_name}."
    puts "Download from: #{url_for_read}"

    template_email({
      link: url_for_read,
      message: "Esta es la lista de marcas",
      title: "Resumen de marcas en el sitio"
    })
  end

  def template_email(params)
    begin
      title = params[:title] rescue "Resumen de marcas en el sitio"
      text_message = params[:message] rescue "Esta es la lista de marcas publicados, los podras encontrar en el siguiente link"
      link = params[:link] rescue "/"
      mandrill ||= Mandrill::API.new "TroFaqX-FKu7l7PIR_JjPg"
      val = {
          "name" => "Valeria Verdejo",
          "type" => "to",
          "email" => "valeria@outofthebox.com"
      }
      gess = {
        "name" => "Gess Gallardo",
        "type" => "to",
        "email" => "hola@gessgallardo.com"
      }
      message = {
          "to"=>[val, gess],
          "text"=>title,
          "headers"=>{"Reply-To"=>"no-reply@gessgallardo.com"},
          "google_analytics_campaign"=>"scarlett@gessgallardo.com",
          "google_analytics_domains"=>["gessgallardo.com"],
          "merge_language"=>"mailchimp",
          "track_clicks"=>false,
          "from_name"=>"Scarlett Gallardo",
          "subject"=>title,
          "html"=>"
            <h4>Hola!</h4>
            <p>#{text_message}</p>
            <br><br>
            <a href='#{link}'>Descargame aqui</a>
            <br><br>
            Saludos Scarlett
          ",
          "merge"=>true,
          "from_email"=>"scarlett@gessgallardo.com"
      }
      result = mandrill.messages.send message
      render json: result.to_json
    rescue Mandrill::Error => e
      error_class = "A mandrill error occurred"
      error_message = "#{e.class} - #{e.message}"
      error_params = {}
      raise e.inspect
      #send_honey_error(error_class, error_message, error_params)
    end
  end
end