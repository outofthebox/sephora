namespace :productos do
	task :update_precios => :environment do
		require 'csv'

		raise "Necesario especificar ruta a FILE.csv" unless ENV['FILE']
		
		file = ENV['FILE'];
		data = []

		csv_text = File.read(file)
		csv = CSV.parse(csv_text, :headers => true)
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
end
