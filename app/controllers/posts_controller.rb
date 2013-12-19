class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).order('created_at DESC')
    else
      @posts = Post.order('created_at DESC')
    end
    Post.last(5)
  end
  def show
    @posts = Post.find params[:id]
    @comment = Comment.new
    @comments = Comment.where(:publicado => true).order('created_at DESC')
  end
  def new
    @posts = Post.new
  end
  def create
    @posts = Post.new params[:post]
    if @posts.save
      redirect_to post_path
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
      redirect_to post_path
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
      redirect_to post_path(params[:id])
    else
      render :show
    end
  end
end
