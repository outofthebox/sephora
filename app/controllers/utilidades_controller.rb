class UtilidadesController < ApplicationController
  def parsearparents
    raise 'error' unless Rails.env.development?

    csv = "/home/sputnik3/Desktop/skusmalditos_#.csv"

    require 'csv'
    skus = []

    # Funcion para varios archivos CSV
    # [1,2,3,4,5,6,7,8].each do |n|
    #   data = CSV.parse(File.open(csv.sub("#", n.to_s)), :headers => true, :return_headers => true )
    #   data.by_col!
    #   data.each do |col|
    #     skus << col.at(1).compact.reject{|r| !(r.to_i > 0) }
    #   end
    # end

    # Funcion para un solo CSV
    data = CSV.parse(File.open('/home/kinduff/Escritorio/improd2.csv'), :headers => true, :return_headers => true )
    data.by_col!
    data.each do |col|
      skus << col.at(1).compact.reject{|r| !(r.to_i > 0) }
    end
    # raise skus.inspect

    s = []
    skus.each do |sku|
      while p = Producto.where(:upc => sku.shift).first do
        # raise p.inspect
        break unless p.nil?
      end

      unless p.nil?
        s << Producto.where(:upc => sku).update_all(:parent_id => p.id)
      end
    end

    raise s.inspect

    raise s.inspect
    raise Producto.where(:upc => s.uniq).size.inspect
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

      # usos = usos.sort.uniq.map do |u|
      #   Uso.new :nombre => u, :visible => true
      # end
      # Uso.import usos

      # categorias = categorias.sort.uniq.map do |c|
      #   Categoria.new :nombre => c, :slug => c.parameterize, :visible => true
      # end
      # Categoria.import categorias

      marcas_existentes = Marca.all.map{|m| m.marca.parameterize }
      marcas = marcas.sort.uniq.map do |m|
        unless m.parameterize.in? marcas_existentes
          Marca.new :marca => m, :slug => m.parameterize 
        end
      end.compact

      Marca.import marcas

      raise 'hecho!'
    else
      marcas = Marca.all.map{|m| { :id => m.id, :marca => m.marca } }
      categorias = Categoria.all.map{|c| { :id => c.id, :categoria => c.nombre } }
      # usos = Uso.all.map{|u| { :id => u.id, :uso => u.nombre } }
      upcs = Producto.all.map{|p| p.upc }.compact
      CSV.foreach(csv) do |row|
        sku = row[1]
        upc = row[2]
        categoria_id = categorias.map{|c| (row[9]||"").parameterize == c[:categoria].parameterize ? c[:id] : nil }.compact.first
        marca_id = marcas.map{|m| row[4].parameterize.gsub('-', '') == m[:marca].parameterize.gsub('-', '') ? m[:id] : nil }.compact.first
        # uso_id = usos.map{|u|
        #   row[10].parameterize == u[:uso].parameterize ? u[:id] : nil
        # }.compact.first
        nombre = row[5]
        nombre_real = row[6]
        precio = row[11]
        descripcion = row[12]
        usos = row[13]
        ingredientes = row[14]
        unless upc.in?(upcs)
          datos << { :sku => sku, :upc => upc, :nombre => nombre, :nombre_real => nombre_real, :precio => precio, :descripcion => descripcion, :usos => usos, :ingredientes => ingredientes, :marca_id => marca_id, :categoria_id => categoria_id }
        end
      end

      datos = datos.drop 1

      datos.each do |dato|
        p = Producto.new dato
        p.save(:validate => false )
      end

      raise datos.inspect
    end
  end

  def imgmover
    require 'csv'
    csv = "/home/oob4/Escritorio/lol.csv"
    skus = []
    CSV.foreach(csv) do |row|
      skus << row[0]
    end
    skus2 = Producto.where(:foto_file_name => nil).map{|r| r.sku}
    skus = (skus + skus2).compact.uniq
    Dir.glob('/media/SIN TITULO/SEPHORA/product images/**/*.jpg').each do |path|
      img_sku = File.basename(path, ".jpg")[/[a-z]?([0-9]+)/i].gsub(/([^0-9])/, '')
      if img_sku.in? skus
        FileUtils.cp path, "/home/oob4/Escritorio/sephora_filtrados/#{img_sku}.jpg"
      end
    end
  end

  def importarimg
    # the logos are in a folder with path logos_dir
    start = 0
    Dir.glob('/home/oob4/Escritorio/sephora_filtrados/*.jpg').each do |logo_path|
      if File.basename(logo_path)[0]!= '.' and !File.directory? logo_path

        sku = File.basename(logo_path, '.*') #filename without extension
        producto = Producto.where(:sku => sku.to_s).first
        raise "could not find client for client_code #{sku}" if producto.nil?

        File.open(logo_path) do |f|
          producto.foto = f # just assign the logo attribute to a file
          producto.save(:validate => false)
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
    existing_upcs = Producto.all.map{|p| p.upc }

    CSV.foreach("/home/sputnik3/Desktop/upc-sku.csv") do |row|
      sku = row.at(0)
      upc = row.at(1)
      data << { :sku => sku, :upc => upc} unless upc.in?(existing_upcs)
      existing_upcs << upc
    end

    productos = Producto.where(:sku => data.map{|d| d[:sku] })

    productos = productos.map do |p|
      p[:upc] = data.reject{|d| p.sku != d[:sku] }.first[:upc]
      { :id => p.id, :upc => p[:upc] }
    end

    Producto.update(productos.map{|p| p[:id] }, productos.map{|p| {"upc" => p[:upc]}})

    raise productos.size.inspect
  end

  def improd
    require 'csv'
    data = []
    CSV.foreach("/home/kinduff/Escritorio/improd.csv") do |row|
      upc = row.at(0)
      marca = row.at(1)
      marca = Marca.find_by_slug(marca.parameterize).id
      nombre = row.at(2)
      nombre_real = row.at(3)
      categoria = row.at(4)
      parent_id = Categoria.find_by_slug(categoria.parameterize).id
      subcategoria = row.at(5)
      if (Categoria.find_by_slug(subcategoria.parameterize))
        categoria = Categoria.find_by_slug(subcategoria.parameterize).id
      else
        r = Categoria.new
        r.nombre = subcategoria
        r.slug = subcategoria.parameterize
        r.visible = true
        r.parent_id = parent_id
        r.save
        categoria = r.id
      end
      precio = row.at(6).to_d
      descripcion = row.at(7)
      data << {:upc => upc,
        :marca_id => marca,
        :nombre => nombre,
        :nombre_real => nombre_real,
        :categoria_id => categoria,
        :descripcion => descripcion,
        :precio => precio
      }
    end
    if(Producto.create(data))
      raise "En CSV: #{data.count}".inspect
    else
      raise "Oops! Something went wrong!".inspect
    end
  end
end
