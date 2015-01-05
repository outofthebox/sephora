class Mobile::PostsController < MobileController
	def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).order('created_at DESC').page(params[:page]).per(5)
    elsif params[:categoria]
      @posts = Post.where(:categoria_id => params[:categoria]).order('created_at DESC').page(params[:page]).per(5)
    else
      @posts = Post.order('created_at DESC').page(params[:page]).per(5)
    end

    @visitas = Post.order('visitas DESC').last(5)
  end

  def show
    @comment = Comment.new
    @ranking = Ranking.new
    @posts = Post.find params[:id]
    @posts.increment
    @visitas = Post.order('visitas DESC').last(5)
  end
end
