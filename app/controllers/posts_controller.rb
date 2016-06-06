require "disqus"

class PostsController < ApplicationController
  before_filter :set_instagram

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
  
  def new
    @posts = Post.new
    @visitas = Post.order('visitas DESC').last(5)
  end
  
  def create
    @posts = Post.new params[:post]
    if @posts.save
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def edit
    @visitas = Post.order('visitas DESC').last(5)
    @posts = Post.find params[:id]
  end
  
  def update
    @posts = Post.find params[:id]
    if @posts.update_attributes params[:post]
      redirect_to posts_path
    else
      render :edit
    end
  end
  
  def destroy
  end

  def comment
    @comment = Comment.new params[:comment]
    @comment.post_id = params[:id]
    if @comment.save
      flash[:notice] = true
      redirect_to posts_path(params[:id])
    else
      render :show
    end
  end

  def ranking
    @ranking = Ranking.new
    @ranking.raiting = params[:commit].to_i.inspect
    @ranking.post_id = params[:id]
    if @ranking.save
      redirect_to posts_path(params[:id])
    else
      render :show
    end
  end

  private

  def set_instagram
    #inst_recent = Instagram.user_recent_media(24459425);
    #@recientes = inst_recent.first(4);
    @recientes = []
  end

  def auth_please
  end
end
