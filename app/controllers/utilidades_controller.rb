class UtilidadesController < ApplicationController
  http_basic_authenticate_with :name => ENV['U'], :password => ENV['P']
  skip_before_filter :verify_authenticity_token, :only => [:descontinuar]
  

  def search
    le_prod = Producto.search params[:buscar][:q]
    le_marca = Marca.search params[:buscar][:q]
    le_categoria = Marca.search params[:buscar][:q]
    busqueda = {:productos => le_prod, :marca => le_marca, :categoria => le_categoria}
    raise busqueda.inspect
    return busqueda
  end

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
    data = CSV.parse(File.open('/Users/oob_dg1/Desktop/pollo/sephora/parents.csv'), :headers => true, :return_headers => true )
    data.by_col!
    data.each do |col|
      skus << col.at(1).compact.reject{|r| !(r.to_i > 0) }
    end
    #raise skus.inspect

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

    #raise s.inspect

    #raise s.inspect
    #raise Producto.where(:upc => s.uniq).size.inspect
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
    Dir.glob('/Users/oob_dg1/Desktop/pollo/sephora/**/*.jpg').each do |path|
      # img_upc = File.basename(path, ".jpg")[/[a-z]?([0-9]+)/i].gsub(/([^0-9])/, '')
      img_upc = File.basename(path, ".jpg")
      if img_upc.in? upcs
        FileUtils.mv path, "/Users/oob_dg1/Desktop/pollo/sephora/sephora_filtrados/#{img_upc}.jpg"
      end
    end
  end

  def importarimg
    # the logos are in a folder with path logos_dir
    start = 0
    Dir.glob('/Users/oob_dg1/Desktop/pollo/sephora/sephora_filtrados/*.jpg').each do |logo_path|
      if File.basename(logo_path)[0]!= '.' and !File.directory? logo_path

        upc = File.basename(logo_path, '.*') #filename without extension
        producto = Producto.where(:image_code => upc.to_s).first
        raise "could not find client for client_code #{upc}" if producto.nil?

        File.open(logo_path) do |f|
          producto.foto = f # just assign the logo attribute to a file
          producto.save(:validate => false)
          FileUtils.mv(logo_path, "/Users/oob_dg1/Desktop/pollo/sephora/sephora_ok/#{upc}.jpg")
          return render :text => "Working... HALT BRO! <script>document.location.reload(true)</script>", :layout => false if (start+=1) > 10
        end #file gets closed automatically here
      end
    end
    render :text => "Gracias por participar :)", :layout => false
  end

  def descontinuar
    require 'csv'

    if params[:file]
      Rails.cache.write('tmp_listaproductos', params[:file].tempfile.read)
      tmp = Rails.cache.read('tmp_listaproductos')
    
      if(params[:descontinuar])
        @data = []
        CSV.parse(tmp, :headers => true) do |row|
          upc = row[0]
          producto = Producto.where(:upc => upc).first
          if(producto != nil)
            puts "[-- Producto Info --]"
            puts producto.inspect
            
            producto.update_attributes(:publicado => false)

            @data <<  producto

          end
        end

        render :descontinuar_guardar
      end
    end

  end

  def descontinuar_guardar
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
    count = 0
    count2 = 0
    CSV.foreach("/home/kinduff/Escritorio/db.csv") do |row|
      unless Producto.where(:upc => row.at(0)).count == 1
        upc = row.at 0
        marca_id = row.at 1
        nombre = row.at 2
        nombre_real = row.at 3
        if row.at(5)
          categoria_id = row.at 5
        else
          categoria_id = row.at 4
        end
        precio = row.at 6
        descripcion = row.at 7
        usos = row.at 8
        ingredientes = row.at 9
        data << {
          :upc => upc,
          :marca_id => marca_id,
          :nombre => nombre,
          :nombre_real => nombre_real,
          :categoria_id => categoria_id,
          :precio => precio,
          :descripcion => descripcion,
          :usos => usos,
          :ingredientes => ingredientes
        }
        count += 1
      else
        count2 += 1
      end
    end
    if(Producto.create(data))
      raise "Perfect: #{count}/#{count2}".inspect
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
    newcount = 0
    total = 0
    CSV.foreach("/home/kinduff/Escritorio/db.csv") do |row|
      if Producto.find_by_upc(row.at(0))
        p = Producto.find_by_upc(row.at(0))
        p.marca_id = Marca.find_by_slug(row.at(1).parameterize)
        p.nombre = row.at 2
        p.nombre_real = row.at 3
        if row.at(5)
          p.categoria_id = row.at 5
        else
          p.categoria_id = row.at 4
        end
        p.precio = row.at 6
        p.save
        datacount = datacount + 1
      else 
        p = Producto.new
        p.upc = row.at 0
        p.marca_id = Marca.find_by_slug(row.at(1).parameterize)
        p.nombre = row.at 2
        p.nombre_real = row.at 3
        if row.at(5)
          p.categoria_id = row.at 5
        else
          p.categoria_id = row.at 4
        end
        p.precio = row.at 6
        p.save
        newcount = newcount + 1
      end
      total = total + 1
    end
    raise "#{datacount} productos actualizados correctamente, #{newcount} agregados correctamente. #{datacount+newcount} en db en total. #{total} en csv en total.".inspect
  end
  def desc
    require 'csv'
    datacount = 0
    csvcount = 0
    CSV.foreach("/home/kinduff/Escritorio/db.csv") do |row|
      if Producto.where(:upc => row.at(1)).first
        p = Producto.where(:upc => row.at(1)).first
        p.sku = row.at(0)
        p.descripcion = row.at(2)
        p.ingredientes = row.at(3)
        p.usos = row.at(4)
        p.save
        datacount = datacount + 1
      end
      csvcount = csvcount + 1
    end
    raise "#{datacount}/#{csvcount} productos ocultados correctamente".inspect
  end
  def cambiar_marcas
    require 'csv'
    gencount = 0
    count = 0
    error = 0
    CSV.foreach("/home/kinduff/Escritorio/sincat.csv") do |row|
      producto = Producto.where(:upc => row.at(0))
      # unless row.at(2).nil? || row.at(2).empty?
      #   marca = row.at(2)
      # else
      #   marca = row.at(1)
      # end
      cat = row.at(1)
      if producto.count == 1
        r = producto.first
        r.categoria_id = cat
        if r.save
          count += 1
        else
          error += 1
        end
      end
      gencount += 1
    end
    raise "#{gencount} productos en total. #{count} productos alterados. #{error} productos con error."
  end
  def editupc
    producto = Producto.where(:upc => params[:upc])
    if producto.count == 1
      redirect_to edit_producto_path(producto.first.id)
    else
      raise 'Not found'.inspect 
    end
  end
  def exportcsv
    require 'csv'
    @final_productos = []
    productos = Marca.all
    respond_to do |format|
      format.html
      format.xml{render :xml => productos}
      #format.xls #{ send_data @final_productos.to_csv(col_sep: "\t") }
      format.xls {send_data productos.to_xls, :filename => "Marca.xls"}
      #  response.headers['Content-Disposition'] = "attachment; filename=sales_#{@final_productos}.xls"
      #  render "exportcsv.xls.haml"
      format.xml
    end
  end
end
