module Mobile::MarcasHelper
	def chomp_desc(descripiton)
		descripiton.lines.map(&:chomp)
	end

	def catalogo_categorias(categorias)
		items = []
		categorias.each do |categoria|
			items << content_tag(
				:ul, 
				content_tag(
					:li,
					catalogo_categoria_item(categoria)
				)
			)
		end
		raw(items.join("\n"))
	end

	def catalogo_categoria_item(categoria)
		items = []
		items << content_tag(:a, categoria.nombre, {:href => categoria.slug})
		items << catalogo_categorias(categoria.children) if categoria.children.any?
		raw(items.join("\n"))
	end

	def embed(youtube_url)
    youtube_id = youtube_url.gsub("&feature=youtu.be", '').split("=").last
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}")
  end
  
end
