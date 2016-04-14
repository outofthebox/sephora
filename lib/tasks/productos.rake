require 'rake'
require "mandrill-api"

namespace :productos do
  task :esconder_incompletos => :environment do
    puts "--- Buscando Productos sin Descripcion ni Imagen"
    sfd = Producto.where({:foto_file_name => nil, :publicado => true, :descripcion => nil})
    sfd_count = sfd.count
    sfd.update_all(:publicado => false)
    puts "--- #{sfd_count} Ocultados"

    puts "--- Buscando Productos sin Descripcion"
    sd = Producto.where({:descripcion => nil, :publicado => true})
    sd_count = sd.count
    sd.update_all(:publicado => false)
    puts "--- #{sd_count} Ocultados"

    puts "--- Buscando Productos sin Imagen"
    sf = Producto.where({:foto_file_name => nil, :publicado => true})
    sf_count = sf.count
    sf.update_all(:publicado => false)
    puts "--- #{sf_count} Ocultados"
  end

  task :unir_productos => :environment do
    require 'csv'
    require 'faraday'
    require 'uri'

    raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']

    file = ENV['FILE'];
    data = []

    if ENV["REMOTE"]

      i = URI(file)

      scheme = i.scheme
      host = i.host
      path = i.path rescue '/'
      query = i.query rescue ''

      host_path = "#{scheme}://#{host}"
      full_path = "#{scheme}://#{host}#{path}#{query}"

      conn = Faraday.new(:url => host_path) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      request = conn.get do |req|
        req.url "#{path}#{query}"
        req.headers['Accept'] = 'application/csv'
      end

      csv = CSV.parse(request.body, :headers => true)
    else
      csv_text = File.read(file)
      csv = CSV.parse(csv_text, :headers => true)
    end

    padre = nil;
    csv.by_col.each do |col|
      if col[0] != nil
        padre = Producto.find_by_upc(col[0])
        if padre != nil
          nombre_padre = padre.nombre || "---"
          puts "Padre: #{nombre_padre}"
          puts "----------------------"
          hijos = col[1]
          hijos.each_with_index do |upc, i|
            if upc != nil
              p = Producto.find_by_upc(upc)
              if p != nil
                p.update_attribute(:parent_id, padre.id)
                codigo = p.upc || "--"
                nombre = p.nombre || "--"
                puts "#{codigo}\t::\t#{nombre}"
              end
            end
          end
        end
      end
    end
  end

  task :update_descuento => :environment do
    require 'csv'
    require 'faraday'
    require 'uri'

    raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']

    code = ENV['CODE'] || "upc"

    file = ENV['FILE'];
    data = []

    if ENV["REMOTE"]

      i = URI(file)

      scheme = i.scheme
      host = i.host
      path = i.path rescue '/'
      query = i.query rescue ''

      host_path = "#{scheme}://#{host}"
      full_path = "#{scheme}://#{host}#{path}#{query}"

      conn = Faraday.new(:url => host_path) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      request = conn.get do |req|
        req.url "#{path}#{query}"
        req.headers['Accept'] = 'application/csv'
      end

      csv = CSV.parse(request.body, :headers => true)
    else
      csv_text = File.read(file)
      csv = CSV.parse(csv_text, :headers => true)
    end

    csv.each do |row|
      upc = row[0];
      descuento = row[1].gsub!("$",'') if row[1]
      descuento = row[1].to_f;
      descuento_porcentual = row[2] if row[2]
      producto = Producto.find_by_upc(upc) if code == "upc"
      producto = Producto.find_by_sap(upc) if code == "sap"
      if producto
        producto.update_attributes({:descuento => descuento, :descuento_porcentual => descuento_porcentual})
        codigo = producto.upc || "--"
        nombre = producto.nombre || "--"
        puts "#{codigo}\t::\t#{nombre}::\t#{descuento}"
      end
    end
  end

  task :clean_descuento => :environment do
    require 'csv'
    require 'faraday'
    require 'uri'

    raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']

    file = ENV['FILE'];
    data = []

    if ENV["REMOTE"]

      i = URI(file)

      scheme = i.scheme
      host = i.host
      path = i.path rescue '/'
      query = i.query rescue ''

      host_path = "#{scheme}://#{host}"
      full_path = "#{scheme}://#{host}#{path}#{query}"

      conn = Faraday.new(:url => host_path) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      request = conn.get do |req|
        req.url "#{path}#{query}"
        req.headers['Accept'] = 'application/csv'
      end

      csv = CSV.parse(request.body, :headers => true)
    else
      csv_text = File.read(file)
      csv = CSV.parse(csv_text, :headers => true)
    end

    csv.each do |row|
      upc = row[0];
      producto = Producto.find_by_upc(upc)
      if producto
        codigo = producto.upc || "--"
        nombre = producto.nombre || "--"
        puts "#{codigo}\t::\t#{nombre}::\t0"
        producto.update_attributes({:descuento => 0, :descuento_porcentual => 0})
      end
    end
  end

	task :update_precios => :environment do
		require 'csv'
    require 'faraday'
    require 'uri'

    raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']

    file = ENV['FILE'];
    headers = ENV['HEADERS'] rescue false
    data = []

    if ENV["REMOTE"]

      i = URI(file)

      scheme = i.scheme
      host = i.host
      path = i.path rescue '/'
      query = i.query rescue ''

      host_path = "#{scheme}://#{host}"
      full_path = "#{scheme}://#{host}#{path}#{query}"

      conn = Faraday.new(:url => host_path) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      request = conn.get do |req|
        req.url "#{path}#{query}"
        req.headers['Accept'] = 'application/csv'
      end

      csv = CSV.parse(request.body, :headers => headers)
    else
		  csv_text = File.read(file)
		  csv = CSV.parse(csv_text, :headers => headers)
    end

		csv.each do |row| code = row[0]; precio_nuevo = row[1]; precio_nuevo = precio_nuevo.to_f; 	data << {:code => code, :precio_nuevo => precio_nuevo}; end

    case ENV["CODE"]
      when "sap" || "SAP"
        productos = Producto.where(:sap => data.map{|d| d[:code]})
        data.map{|d|
          if (producto = productos.reject{|p| p unless p.sap == d[:code] }.first)
            if producto
              d[:precio_actual] = producto.precio
              d[:producto] = producto.nombre
              d[:id] = producto.id
            end
          end
        }
      else
		    productos = Producto.where(:upc => data.map{|d| d[:code]})
        data.map{|d|
          if (producto = productos.reject{|p| p unless p.upc == d[:code] }.first)
            if producto
              d[:precio_actual] = producto.precio
              d[:producto] = producto.nombre
              d[:id] = producto.id
            end
          end
        }
    end

    precios = []
    ids = []

    puts "##########################################################"
		puts "##\tPRODUCTOS\t||\tANTES\t||\tDESPUES\t##"
    data.each do |d|
      if d.has_key?(:precio_actual)
        precios << {:precio => d[:precio_nuevo]}
        ids << d[:id]
				puts "#--------------------------------------------------------#"
				puts "##\t#{d[:id]}\t||\t#{d[:precio_actual]}\t||\t#{d[:precio_nuevo]}\t##"
      end
    end
    puts "##########################################################"

    if Producto.update(ids, precios)
    	puts "################### -- SUCCESS -- ########################"
    else
      puts "##################### -- ERROR -- ########################"
    end
	end

	task :update_publicados => :environment do
		require 'csv'

		raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']

		file = ENV['FILE'];

		data = []
		csv_text = File.read(file)
		csv = CSV.parse(csv_text, :headers => true)

		csv.each do |c| data << c["UPC"] unless c["UPC"] == nil; end

		activos_before =  Producto.publicados.count
		activos = Producto.where(:upc => data)
		activos.each do |a| a.update_attribute(:publicado, true) unless (a.publicado == true); end
		activos_after = Producto.publicados.count

		descontinuados_before =  Producto.where(:publicado => false).count
		descontinuados = Producto.where("upc not in (?)", data)
		descontinuados.each do |d| d.update_attribute(:publicado, false) unless (d.publicado == false); end
		descontinuados_after =  Producto.where(:publicado => false).count

		puts "##########################################################"
		puts "##\tPRODUCTOS\t||\tANTES\t||\tDESPUES\t##"
		puts "##\tACTIVOS\t\t||\t#{activos_before}\t||\t#{activos_after}\t##"
		puts "##\tDESCONTINUADOS\t||\t#{descontinuados_before}\t||\t#{descontinuados_after}\t##"
		puts "##########################################################"
	end

	task :descontinuados => :environment do
		require 'csv'
		require 'remote_file'

		raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']

		file = ENV['FILE'];
		data = []

		if ENV["REMOTE"]
		  rm = RemoteFile.new(file)
		  csv = CSV.parse(rm.request.body, :headers => true)
		else
		  csv_text = File.read(file)
		  csv = CSV.parse(csv_text, :headers => true)
		end

		csv.each do |c| data << c[0] unless c[0] == nil; end

		descontinuados_before =  Producto.where(:publicado => false).count
		descontinuados = Producto.where(:upc => data)
		descontinuados.each do |d| d.update_attribute(:publicado, false) unless (d.publicado == false); end
		descontinuados_after =  Producto.where(:publicado => false).count

		puts "##########################################################"
		puts "##\tPRODUCTOS\t||\tANTES\t||\tDESPUES\t##"
		puts "##\tDESCONTINUADOS\t||\t#{descontinuados_before}\t||\t#{descontinuados_after}\t##"
		puts "##########################################################"
  end

  task :reactivados => :environment do
    require 'csv'
    require 'remote_file'

    raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']

    file = ENV['FILE'];
    data = []

    if ENV["REMOTE"]
      rm = RemoteFile.new(file)
      csv = CSV.parse(rm.request.body, :headers => true)
    else
      csv_text = File.read(file)
      csv = CSV.parse(csv_text, :headers => true)
    end

    csv.each do |c| data << c[0] unless c[0] == nil; end

    reactivados_before =  Producto.where(:publicado => true).count
    reactivados = Producto.where(:upc => data)
    reactivados.each do |d| d.update_attribute(:publicado, true) unless (d.publicado == true); end
    reactivados_after =  Producto.where(:publicado => true).count

    puts "##########################################################"
    puts "##\tPRODUCTOS\t||\tANTES\t||\tDESPUES\t##"
    puts "##\treactivados\t||\t#{reactivados_before}\t||\t#{reactivados_after}\t##"
    puts "##########################################################"
  end

  task :populate_sap => :environment do
    require 'csv'
    require 'remote_file'

    raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']

    file = ENV['FILE'];
    data = []

    if ENV["REMOTE"]
      rm = RemoteFile.new(file)
      csv = CSV.parse(rm.request.body, :headers => true)
    else
      csv_text = File.read(file)
      csv = CSV.parse(csv_text, :headers => true)
    end

    csv.each do |c|
      upc = c["UPC"] rescue nil
      sap = c["SAP"] rescue nil
      unless upc == nil
        producto = Producto.find_by_upc(upc) rescue nil
        producto.update_attribute(:sap, sap) if producto && sap != nil
        puts "#{producto.nombre}\t\t::\t\t#{producto.sap}" if producto && sap != nil
      end
    end
  end

  task :publicados => :environment do
    #AWS S3 SETUP
    bucket_name = "sephoramexico"
    temp_file = Tempfile.new("publicados_#{Date.today.to_s}")
    key_path = "productos/"+File.basename(temp_file)+".csv"
    s3 = AWS::S3.new

    CSV.open(temp_file, "w") do |csv|
      productos = Producto.includes(:marca).publicados.select([:nombre, :upc, :sap, :marca_id, :nombre_real])
      csv << ["nombre", "upc", "sap", "marca"]
      productos.each do |p|
        marca_name = p.marca.marca rescue ""
        csv << [p.nombre, p.upc, p.sap, marca_name]
      end
    end

    s3.buckets[bucket_name].objects[key_path].write(:file => temp_file.path, :acl => :public_read)
    url_for_read = s3.buckets[bucket_name].objects[key_path].url_for(:read) rescue "/"

    puts "Uploading file #{temp_file.path} to bucket #{bucket_name}."
    puts "Download from: #{url_for_read}"

    template_email({
      link: url_for_read,
      message: "Esta es la lista de productos publicados, los podras encontrar en el siguiente link",
      title: "Resumen de productos en el sitio"
    })
  end

  task :no_publicados => :environment do
    #AWS S3 SETUP
    bucket_name = "sephoramexico"
    temp_file = Tempfile.new("descontinuados_#{Date.today.to_s}")
    key_path = "productos/"+File.basename(temp_file)+".csv"
    s3 = AWS::S3.new

    CSV.open(temp_file, "w") do |csv|
      productos = Producto.includes(:marca).no_publicados.select([:nombre, :upc, :sap, :marca_id, :nombre_real])
      csv << ["nombre", "upc", "sap", "marca"]
      productos.each do |p|
        marca_name = p.marca.marca rescue ""
        csv << [p.nombre, p.upc, p.sap, marca_name]
      end
    end

    s3.buckets[bucket_name].objects[key_path].write(:file => temp_file.path, :acl => :public_read)
    url_for_read = s3.buckets[bucket_name].objects[key_path].url_for(:read) rescue "/"

    puts "Uploading file #{temp_file.path} to bucket #{bucket_name}."
    puts "Download from: #{url_for_read}"

    template_email({
      link: url_for_read,
      message: "Esta es la lista de productos no publicados, los podras encontrar en el siguiente link",
      title: "Resumen de productos descontinuados en el sitio"
    })
  end

  #sanitizers
  task :sanitize_discount => :environment do
    Producto.where(:descuento => nil).each do |pd|
      pd.update_attribute(:descuento, 0)
    end
  end

  task :sanitize_discount_percent => :environment do
    Producto.where(:descuento_porcentual => nil).each do |pd|
      pd.update_attribute(:descuento_porcentual, 0)
    end
  end

  def template_email(params)
    begin
      title = params[:title] rescue "Resumen de productos en el sitio"
      text_message = params[:message] rescue "Esta es la lista de productos publicados, los podras encontrar en el siguiente link"
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