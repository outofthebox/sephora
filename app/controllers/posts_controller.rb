class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).order('created_at DESC')
    else
      @posts = Post.order('created_at DESC')
    end
  end
  def show
    @post = Post.find params[:id]
    @comment = Comment.new
    @comments = @post.comments.where(:publicado => true, :tipo => 1).order('created_at DESC')
  end
  def new
    @posts = Post.new
  end
  def create
    @posts = Post.new params[:post]
    if @posts.save
      redirect_to blog_post(@post)
    else
      render :new
    end
  end
  def edit
    @posts = Post.find params(:id)
  end
  def update
    @posts = Post.find params(:id)
    if @posts.update_attributes params[:post]
      redirect_to blog_post(@post)
    else
      render :edit
    end
  end
  def destroy
    
  end
  def comment
    @comment = Comment.new params[:comment]
    @comment.parent = params[:id]
    @comment.tipo = 1
    if @comment.save
      flash[:notice] = true
      redirect_to post_path(params[:id])
    else
      render :show
    end
  endclass PostsController < ApplicationController
end
end
