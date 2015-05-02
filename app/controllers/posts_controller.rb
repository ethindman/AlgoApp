class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(:user).order(created_at: "DESC").paginate(page: params[:page], per_page: 15)
  end

  def new
  end

  def create
    @post = User.find(session[:user_id]).posts.create( post_params )
    if @post.save
      flash[:success] = "New algorithm added!"
      redirect_to :users
    else 
      flash[:errors_array] = @post.errors.full_messages
      redirect_to "/posts/new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = Post.find(params[:id]).comments.includes(:user)
    @user = User.find(@post.user_id)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == session[:user_id]
      @post.destroy
      flash[:success] = "Algorithm deleted!"
      redirect_to :users
    else
      flash[:errors] = "You can only delete your own posts"
      redirect_to :users
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    Post.find(params[:id]).update( post_params )
    flash[:success] = "Algorithm updated!"
    redirect_to :post
  end
  private 
  def post_params
   params.require(:post).permit(:title, :code, :description, :difficulty, :category)
  end
end
