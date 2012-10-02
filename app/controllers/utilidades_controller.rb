class UtilidadesController < ApplicationController
  def parsearparents
    raise 'error' unless Rails.env.development?

    csv = "/home/sputnik3/Desktop/skusmalditos_#.csv"

    require 'csv'
    skus = []

    [1,2,3,4,5,6,7,8].each do |n|
      data = CSV.parse(File.open(csv.sub("#", n.to_s)), :headers => true, :return_headers => true )
      data.by_col!
      data.each do |col|
        skus << col.at(1).compact.reject{|r| !(r.to_i > 0) }
      end
    end

    raise skus.inspect

    s = []
    skus.each do |sku|
      while p = Producto.where(:sku => sku.shift).first do
        # raise p.inspect
        break unless p.nil?
      end

      unless p.nil?
        s << Producto.where(:sku => sku).update_all(:parent_id => p.id)
      end
    end

    raise s.inspect

    raise s.inspect
    raise Producto.where(:sku => s.uniq).size.inspect
  end

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

  def actprecios
    require 'csv'
    data = []
    if params[:file]
      Rails.cache.write('tmp_listadeprecio', params[:file].tempfile.read)
      tmp = Rails.cache.read('tmp_listadeprecio')
      CSV.parse(tmp, :headers => true) do |row|
        sku = row[0]
        precio_nuevo = row[1]
        data << {:sku => sku, :precio_nuevo => precio_nuevo}
      end

      productos = Producto.where(:sku => data.map{|d| d[:sku]})

      data.map{|d|
        if (producto = productos.reject{|p| p unless p.sku == d[:sku] }.first)
          if producto
            d[:precio_actual] = producto.precio
            d[:producto] = producto.nombre
          end
        end
      }
      @data = data
    end
  end

  def actprecios_guardar
    require 'csv'
    data = []
    tmp = Rails.cache.read('tmp_listadeprecio')
    CSV.parse(tmp, :headers => true) do |row|
      sku = row[0]
      precio_nuevo = row[1]
      data << {:sku => sku, :precio_nuevo => precio_nuevo}
    end

    productos = Producto.where(:sku => data.map{|d| d[:sku]})

    data.map{|d|
      if (producto = productos.reject{|p| p unless p.sku == d[:sku] }.first)
        if producto
          d[:precio_actual] = producto.precio
          d[:producto] = producto.nombre
          d[:id] = producto.id
        end
      end
    }
    @data = data
    precios = []
    ids = []
    @data.each do |d|
      if d.has_key?(:precio_actual)
        precios << {:precio => d[:precio_nuevo]}
        ids << d[:id]
      end
    end
    if Producto.update(ids, precios)
      @actualizado = true
      render :actprecios
    else
      raise 'error'
    end
  end

  def update_upc
    require 'csv'
    data = []
    CSV.foreach("/home/sputnik3/Desktop/upc-sku.csv") do |row|
      sku = row.at(0)
      upc = row.at(1)
      data << { :sku => sku, :upc => upc}
    end

    productos = Producto.where(:sku => data.map{|d| d[:sku] })

    productos = productos.map do |p|
      p[:upc] = data.reject{|d| p.sku != d[:sku] }.first[:upc]
      { :id => p.id, :upc => p[:upc] }
    end

    people = { 1 => { "first_name" => "David" }, 2 => { "first_name" => "Jeremy" } }

    Producto.update(productos.map{|p| p[:id] }, productos.map{|p| {"upc" => p[:upc]}})

    raise productos.size.inspect
  end
end
