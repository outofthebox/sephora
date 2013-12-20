require 'ostruct'

module PostsHelper
	def stats(id)
		le_post = Post.find id
    le_categorias = BlogCategoria.where(:id => le_post.categoria_id)
    le_comments = Comment.where(:publicado => true, :post_id => id).order('created_at DESC')
    json = {:post => le_post, :categorias => le_categorias, :comments => le_comments}
    
    stats = OpenStruct.new(json)
    return stats
	end
end
