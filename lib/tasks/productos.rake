require 'rake'

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
      descuento_porcentual = row[2].gsub!("%",'') if row[2]
      producto = Producto.find_by_upc(upc)
      if producto
        codigo = producto.upc || "--"
        nombre = producto.nombre || "--"
        puts "#{codigo}\t::\t#{nombre}::\t#{descuento}"
        producto.update_attributes({:descuento => descuento, :descuento_porcentual => descuento_porcentual})
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
    
		csv.each do |row| upc = row[0]; precio_nuevo = row[1]; precio_nuevo = precio_nuevo.to_f; 	data << {:upc => upc, :precio_nuevo => precio_nuevo}; end

		productos = Producto.where(:upc => data.map{|d| d[:upc]})

		data.map{|d|
      if (producto = productos.reject{|p| p unless p.upc == d[:upc] }.first)
        if producto
          d[:precio_actual] = producto.precio
          d[:producto] = producto.nombre
          d[:id] = producto.id
        end
      end
    }

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

		csv.each do |c| data << c["UPC"] unless c["UPC"] == nil; end

		descontinuados_before =  Producto.where(:publicado => false).count
		descontinuados = Producto.where(:upc => data)
		descontinuados.each do |d| d.update_attribute(:publicado, false) unless (d.publicado == false); end
		descontinuados_after =  Producto.where(:publicado => false).count

		puts "##########################################################"
		puts "##\tPRODUCTOS\t||\tANTES\t||\tDESPUES\t##"
		puts "##\tDESCONTINUADOS\t||\t#{descontinuados_before}\t||\t#{descontinuados_after}\t##"
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
end