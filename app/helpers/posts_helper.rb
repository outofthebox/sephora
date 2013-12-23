require 'ostruct'

module PostsHelper
	def stats(id)
		le_post = Post.find id
		le_tags = le_post.tags;
    le_categorias = BlogCategoria.where(:id => le_post.categoria_id)
    le_comments = Comment.where(:publicado => true, :post_id => id).order('created_at DESC')
    le_love = PostFav.where(:id => id)

		raiting = Ranking.where(:post_id => params[:id]).sum('raiting') 
		total = Ranking.where(:post_id => params[:id]).count

		res = 0;
		if  total > 0
			res = raiting/total
		end

    json = {:post => le_post, :categorias => le_categorias, :comments => le_comments, :ranking => res, :tags => le_tags, :love => le_love}
    
    stats = OpenStruct.new(json)

    return stats
	end
end
