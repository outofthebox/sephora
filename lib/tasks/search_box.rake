require 'rake'

namespace :search_box do
	include Rails.application.routes.url_helpers
  task :populate => :environment do
  	query = "select p.nombre as label, 'Productos' as category, p.slug as slug from productos as p where p.publicado = true"
  	productos = 	ActiveRecord::Base.connection.execute(query)
  	productos_array = productos.map{|p| {label: p["label"], category: p["category"], link: "/producto/"+p["slug"]}}

  	query = "select m.marca as label, 'Marcas' as category, m.slug as slug from marcas as m"
  	marcas = 	ActiveRecord::Base.connection.execute(query)
  	marcas_array = marcas.map{|p| {label: p["label"], category: p["category"], link: "/marca/"+p["slug"]}}

  	query = "select c.nombre as label, 'Categorias' as category, c.slug as slug from categorias as c"
  	categorias = 	ActiveRecord::Base.connection.execute(query)
  	categorias_array = categorias.map{|p| {label: p["label"], category: p["category"], link: "/categoria/"+p["slug"]}}

		search_array = productos_array + marcas_array + categorias_array
		search_array.to_json
	end
end