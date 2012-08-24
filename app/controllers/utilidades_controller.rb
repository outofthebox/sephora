class UtilidadesController < ApplicationController
  load_and_authorize_resource
  def importar
    raise 'error' unless Rails.env.development?

    csv = "/home/sputnik3/Desktop/sephora.csv"

    require 'csv'
    datos = []

    case params[:quoi]
    when 'marcas'
      marcas = []
      categorias = []
      usos = []
      CSV.foreach(csv) do |row|
        marcas << row[4]
        categorias << row[8]
        categorias << row[9]
        usos << row[10]
      end

      usos = usos.sort.uniq.map do |u|
        Uso.new :nombre => u, :visible => true
      end
      Uso.import usos

      categorias = categorias.sort.uniq.map do |c|
        Categoria.new :nombre => c, :slug => c.parameterize, :visible => true
      end
      Categoria.import categorias

      marcas = marcas.sort.uniq.map do |m|
        Marca.new :marca => m, :slug => m.parameterize
      end
      Marca.import marcas

      raise 'hecho!'
    else
      marcas = Marca.all.map{|m| { :id => m.id, :marca => m.marca } }
      categorias = Categoria.all.map{|c| { :id => c.id, :categoria => c.nombre } }
      # usos = Uso.all.map{|u| { :id => u.id, :uso => u.nombre } }
      CSV.foreach(csv) do |row|
        sku = row[1]
        categoria_id = categorias.map{|c| row[9].parameterize == c[:categoria].parameterize ? c[:id] : nil }.compact.first
        marca_id = marcas.map{|m| row[4].parameterize == m[:marca].parameterize ? m[:id] : nil }.compact.first
        # uso_id = usos.map{|u|
        #   row[10].parameterize == u[:uso].parameterize ? u[:id] : nil
        # }.compact.first
        nombre = row[5]
        nombre_real = row[6]
        precio = row[11]
        descripcion = row[12]
        usos = row[13]
        ingredientes = row[14]
        datos << { :sku => sku, :nombre => nombre, :nombre_real => nombre_real, :precio => precio, :descripcion => descripcion, :usos => usos, :ingredientes => ingredientes, :marca_id => marca_id, :categoria_id => categoria_id } if sku.length > 3
      end

      # datos = datos.drop 1

      datos.each do |dato|
        p = Producto.new dato
        p.save(:validate => false )
      end

      raise datos.inspect
    end
  end

  def importarimg
    # the logos are in a folder with path logos_dir
    start = 0
    Dir.glob('/home/oob4/Escritorio/sephora_filtrados/**/*.jpg').each do |logo_path|
      if File.basename(logo_path)[0]!= '.' and !File.directory? logo_path

        sku = File.basename(logo_path, '.*') #filename without extension
        producto = Producto.where(:sku => sku.to_s).first
        raise "could not find client for client_code #{sku}" if producto.nil?

        File.open(logo_path) do |f|
          producto.foto = f # just assign the logo attribute to a file
          producto.save
          FileUtils.mv(logo_path, "/home/oob4/Escritorio/sephora_filtrados_OK/#{sku}.jpg")
          return render :text => "Working... HALT BRO! <script>document.location.reload(true)</script>", :layout => false if (start+=1) > 10
        end #file gets closed automatically here
      end
    end
    render :text => "Gracias por participar :)", :layout => false
  end
end
