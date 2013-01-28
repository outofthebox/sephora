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
    # require 'csv'
    # csv = "/home/oob4/Escritorio/lol.csv"
    # skus = []
    # CSV.foreach(csv) do |row|
    #   skus << row[0]
    # end
    upcs = Producto.all.map{|r| r.upc}
    # upcs = (upcs + upcs2).compact.uniq
    Dir.glob('/home/kinduff/Escritorio/sephora/**/*.jpg').each do |path|
      # img_upc = File.basename(path, ".jpg")[/[a-z]?([0-9]+)/i].gsub(/([^0-9])/, '')
      img_upc = File.basename(path, ".jpg").gsub(/[^\d]/, '')
      if img_upc.in? upcs
        FileUtils.cp path, "/home/kinduff/Escritorio/sephora_filtrados/#{img_upc}.jpg"
      end
    end
  end

  def importarimg
    # the logos are in a folder with path logos_dir
    start = 0
    Dir.glob('/home/kinduff/Escritorio/sephora_filtrados/*.jpg').each do |logo_path|
      if File.basename(logo_path)[0]!= '.' and !File.directory? logo_path

        upc = File.basename(logo_path, '.*') #filename without extension
        producto = Producto.where(:upc => upc.to_s).first
        raise "could not find client for client_code #{upc}" if producto.nil?

        File.open(logo_path) do |f|
          producto.foto = f # just assign the logo attribute to a file
          producto.save(:validate => false)
          FileUtils.mv(logo_path, "/home/kinduff/Escritorio/sephora_ok/#{upc}.jpg")
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
        upc = row[0]
        precio_nuevo = row[1]
        if precio_nuevo.is_a?(String)
          precio_nuevo = precio_nuevo.gsub(/[^\d\.]/, '').to_f
        end
        data << {:upc => upc, :precio_nuevo => precio_nuevo}
      end

      productos = Producto.where(:upc => data.map{|d| d[:upc]})

      data.map{|d|
        if (producto = productos.reject{|p| p unless p.upc == d[:upc] }.first)
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
      upc = row[0]
      precio_nuevo = row[1]
      if precio_nuevo.is_a?(String)
        precio_nuevo = precio_nuevo.gsub(/[^\d\.]/, '').to_f
      end
      data << {:upc => upc, :precio_nuevo => precio_nuevo}
    end

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
    existen = []
    CSV.foreach("/home/kinduff/Escritorio/db.csv") do |row|
    # unless Producto.find_by_upc(row.at(1))
      sku = row.at(0)
      upc = row.at(1).gsub(/\s+/, "")
      marca = 183
      # if Marca.find_by_slug(marca.parameterize)
      #   marca = Marca.find_by_slug(marca.parameterize).id
      # else
      #   r = Marca.new
      #   r.marca = marca
      #   r.slug = marca.parameterize
      #   r.save
      #   marca = r.id
      # end
      nombre = row.at(2)
      nombre_real = row.at(3)
      # categoria = row.at(5)
      # parent_id = Categoria.find_by_slug(categoria.parameterize).id
      # subcategoria = row.at(6)
      # if (Categoria.find_by_nombre(subcategoria))
      #   categoria = Categoria.find_by_nombre(subcategoria).id
      # else
      #   r = Categoria.new
      #   r.nombre = subcategoria
      #   r.slug = subcategoria.parameterize
      #   r.visible = true
      #   r.parent_id = parent_id
      #   r.save
      #   categoria = r.id
      # end
      categoria = row.at(5)
      # unless row.at(10).nil?
      #   categoria = Categoria.find(row.at(10)).id
      #   # if (Categoria.find_by_nombre(grupo))
      #   #   categoria = Categoria.find_by_nombre(grupo).id
      #   # else
      #   #   r = Categoria.new
      #   #   r.nombre = grupo
      #   #   r.slug = grupo.parameterize
      #   #   r.visible = true
      #   #   r.parent_id = categoria
      #   #   r.save
      #   #   categoria = r.id
      #   # end
      # end
      precio = row.at(6).to_d
      descripcion = row.at(7)
      detalles = row.at(8)
      data << {
        :sku => sku,
        :upc => upc,
        :marca_id => marca,
        :nombre => nombre,
        :nombre_real => nombre_real,
        :categoria_id => categoria,
        :descripcion => descripcion,
        :precio => precio,
        :usos => detalles
      }
      # else
      #   puts "http://sephora.com.mx/producto/#{Producto.find_by_upc(row.at(1)).slug}"
      # end
    end
    # raise data.inspect
    if(Producto.create(data))
      raise 'Perfect'.inspect
    else
      raise "Oops! Something went wrong!".inspect
    end
  end
  def cambiarnombres
    require 'csv'
    CSV.foreach("/home/kinduff/Escritorio/names.csv") do |row|
      upc = row.at(0)
      nombre_real = row.at(1)
      r = Producto.where(:upc => upc).first
      r.nombre_real = nombre_real
      r.save
    end
    raise 'Actualizados correctamente'.inspect
  end
  def actualizar
    require 'csv'
    datacount = 0
    CSV.foreach("/home/kinduff/Escritorio/faced.csv") do |row|
      if Producto.find_by_upc(row.at(2))
        p = Producto.find_by_upc(row.at(2))
        p.sku = row.at 1
        p.nombre = row.at 5
        p.nombre_real = row.at 6
        p.precio = row.at 11
        p.descripcion = row.at 12
        p.usos = row.at 13
        p.ingredientes = 14
        p.save
        datacount = datacount + 1
      end
    end
    raise "#{datacount} productos actualizados correctamente".inspect
  end
  def desc
    require 'csv'
    datacount = 0
    csvcount = 0
    CSV.foreach("/home/kinduff/Escritorio/desc.csv") do |row|
      if Producto.where(:upc => row.at(0)).first
        p = Producto.where(:upc => row.at(0)).first
        p.publicado = false
        p.save
        datacount = datacount + 1
      end
      csvcount = csvcount + 1
    end
    raise "#{datacount}/#{csvcount} productos ocultados correctamente".inspect
  end
end
