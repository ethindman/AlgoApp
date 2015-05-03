class PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.includes(:user).order(created_at: "DESC").paginate(page: params[:page], per_page: 15)
  end

  def new
  end

  def create
    @post = @user.posts.create(post_params)
    if @post.save
      flash[:success] = "New algorithm added!"
      redirect_to :users
    else 
      flash[:errors_array] = @post.errors.full_messages
      redirect_to "/posts/new"
    end
  end

  def show
    @user = User.find(@post.user_id)
    @comments = Post.find(params[:id]).comments.includes(:user)
  end

  def destroy
    if @post.user_id != @user.id
      flash[:errors] = "You can't delete another user's posts."
      redirect_to :users
    else 
      @post.destroy
      flash[:success] = "Your algorithm was successfully deleted!"
      redirect_to :users
    end
  end

  def edit
    if @post.user_id != @user.id
      flash[:errors] = "You don't have permission to edit this post."
      redirect_to :posts
    else
      @post = Post.find(params[:id])
    end
  end

  def update
    if @post.user_id != @user.id
      flash[:errors] = "You don't have permission to edit this post."
      redirect_to :posts
    else
      @post.update( post_params )
      if @post.save
        flash[:success] = "Algorithm updated!"
        redirect_to :post
      else 
        flash[:errors] = "Couldn'update algorithm... Please try again later"
        redirect_to :post
      end
    end
  end

  private
    def set_user
      @user = User.find(session[:user_id])
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
     params.require(:post).permit(:title, :code, :description, :difficulty, :category)
    end

end
