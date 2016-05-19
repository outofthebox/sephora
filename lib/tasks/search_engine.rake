require 'rake'
require "mandrill"

namespace :search_engine do
  task :update => :environment do
    search_cats = []; 

    bucket_name = "sephoramexico"
    temp_file = Tempfile.new("search_engine")
    key_path = "settings/search_engine.js"
    s3 = AWS::S3.new
    
    search_marcas      =  Marca.con_productos
    search_categorias  =  Categoria.all
    search_productos   =  Producto.publicados

    search_marcas.map! do |m| {label: m.marca, category: "Marcas", link: "/marca/"+m.slug} end
    search_categorias.map! do |c| {label: c.nombre, category: "Categorias", link: "/categoria/"+c.slug} end
    search_productos.map! do |p| {label: p.nombre, category: "Productos", link: "/producto/"+p.slug} end

    search_cats = search_marcas + search_categorias + search_productos

    temp_file.write("var search_cat = "+search_cats.to_json)

    s3.buckets[bucket_name].objects[key_path].write(:file => temp_file.path, :acl => :public_read)
    url_for_read = s3.buckets[bucket_name].objects[key_path].url_for(:read) rescue "/"

    puts "#{url_for_read}"
  end
end