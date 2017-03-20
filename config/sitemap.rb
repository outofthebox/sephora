# Change this to your host. See the readme at https://github.com/lassebunk/dynamic_sitemaps
# for examples of multiple hosts and folders.
host "www.sephora.com.mx"

sitemap :site do
  url root_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
  url obsequios_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
  url politicas_url, last_mod: Time.now, change_freq: "monthly", priority: 1.0
  url politicas_privacidad_url, last_mod: Time.now, change_freq: "monthly", priority: 1.0
  url promociones_show_url, last_mod: Time.now, change_freq: "monthly", priority: 1.0

  url posts_url, last_mod: Time.now, change_freq: "weekly", priority: 1.0

  url obsequios_url({rango: "500"}), last_mod: Time.now, change_freq: "weekly", priority: 1.0
  url obsequios_url({rango: "500-1000"}), last_mod: Time.now, change_freq: "weekly", priority: 1.0
  url obsequios_url({rango: "1000-1500"}), last_mod: Time.now, change_freq: "weekly", priority: 1.0
  url obsequios_url({rango: "1500-2000"}), last_mod: Time.now, change_freq: "weekly", priority: 1.0
  url obsequios_url({rango: "2000"}), last_mod: Time.now, change_freq: "weekly", priority: 1.0
end

sitemap_for Post.publicados, name: :published_posts do |post|
  url post, last_mod: post.updated_at, priority: 1.0
end

sitemap_for Producto.publicados, name: :published_categorias do |product|
  url producto_ver_url(product.slug), last_mod: product.updated_at, priority: 1.0
end

sitemap_for Categoria.scoped, name: :visible_categories do |categoria|
  url categoria_ver_url(categoria.slug), last_mod: categoria.updated_at, priority: 1.0
end

# Ping search engines after sitemap generation:
#

ping_with "http://#{host}/sitemap.xml"