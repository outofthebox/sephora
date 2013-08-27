# encoding: utf-8

hr = "===================================="
hr2 = "------------------------------------"

namespace :import do
  task :csv => :environment do
    require 'csv'
    require 'open-uri'

    raise "Declara archivo csv." unless ENV['csv']

    csv = ENV['csv']
    productos = []
    puts hr
    puts "Looping CSV..."
    puts hr
    CSV.foreach(csv) do |row|
      upc = row.at(0)
      image_code = row.at(1)
      nombre = row.at(2)
      precio = row.at(3)
      productos << {
        :upc => upc,
        :image_code => image_code,
        :nombre => nombre,
        :precio => precio,
        :categoria_id => 78,
        :marca_id => 52
      }
      puts "#{upc} - OK"
    end
    puts hr2
    puts "Guardando..."
    if Producto.create(productos)
      puts "Guardados. OK. #{productos.count}"
    end
  end
  task :update => :environment do
    require 'csv'
    require 'open-uri'

    raise "Declara archivo csv." unless ENV['csv']

    csv = ENV['csv']
    CSV.foreach(csv) do |row|
      upc = row.at(0)
      producto = Producto.find_by_upc(upc)
      producto.marca_id = 52
      if producto.save
        puts "#{producto.upc} - OK"
      end
    end
    puts "Done."
  end
  task :images => :environment do
    puts hr
    puts "Importing images"
    puts hr
    Dir.glob('/home/kinduff/Escritorio/sephora_filtrados/*.jpg').each do |logo_path|
      if File.basename(logo_path)[0]!= '.' and !File.directory? logo_path

        upc = File.basename(logo_path, '.*') #filename without extension
        producto = Producto.where(:image_code => upc.to_s).first
        raise "could not find client for client_code #{upc}" if producto.nil?
        puts "#{producto.upc} - UPLOADING"
        File.open(logo_path) do |f|
          producto.foto = f # just assign the logo attribute to a file
          producto.save(:validate => false)
          FileUtils.mv(logo_path, "/home/kinduff/Escritorio/sephora_ok/#{upc}.jpg")
          puts "#{producto.upc} - OK"
        end #file gets closed automatically here
      end
    end
    puts hr2
    puts "Done."
  end
end
