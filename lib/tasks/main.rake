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
      marca = row.at(1)
      nombre = row.at(2)
      nombre_real = row.at(3)
      categoria = row.at(4)
      precio = row.at(5)
      descripcion = row.at(6)
      usos = row.at(7)
      ingredientes = row.at(8)
      unless Producto.find_by_upc(upc)
        productos << {
          :upc => upc,
          :nombre => nombre,
          :nombre_real => nombre_real,
          :precio => precio,
          :categoria_id => categoria,
          :marca_id => marca,
          :descripcion => descripcion,
          :ingredientes => ingredientes,
          :usos => usos,
          :publicado => true
        }
        puts "#{upc} - OKAY"
        puts "#{nombre} - ok"
      else
        puts "#{upc} - NOPE"
      end
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
      producto.marca_id = 144
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
    Dir.glob('/Users/oob_dg1/Desktop/pollo/sephora/sephora_filtrados/*.jpg').each do |logo_path|
      if File.basename(logo_path)[0]!= '.' and !File.directory? logo_path

        upc = File.basename(logo_path, '.*') #filename without extension
        producto = Producto.where(:upc => upc.to_s).first
        raise "could not find client for client_code #{upc}" if producto.nil?
        puts "#{producto.upc} - UPLOADING"
        File.open(logo_path) do |f|
          producto.foto = f # just assign the logo attribute to a file
          producto.save(:validate => false)
          FileUtils.mv(logo_path, "/Users/oob_dg1/Desktop/pollo/sephora/sephora_ok/#{upc}.jpg")
          puts "#{producto.upc} - OK"
        end #file gets closed automatically here
      end
    end
    puts hr2
    puts "Done."
  end
end
