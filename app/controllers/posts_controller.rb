class PostsController < ApplicationController
  before_action :current_user
  before_action :require_signed_in
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.includes(:user).order(created_at: "DESC").paginate(page: params[:page], per_page: 15)
    @followships = Followship.all
  end

  def new
  end

  def create
    @post = @current_user.posts.create(post_params)
    if @post.save
      flash[:success] = "New algorithm added!"
      redirect_to :users
    else 
      flash[:errors_array] = @post.errors.full_messages
      redirect_to "/posts/new"
    end
  end

  def show
    @user = User.select("id, first_name, last_name, belts, gravatar, summary, created_at").find(@post.user_id)
    @comments = Post.find(params[:id]).comments.includes(:user).paginate(page: params[:page], per_page: 15)
    @favorites = Post.find(params[:id]).favorites
    
    if @comments.blank?
      @avg_review = 0
    else
      @avg_review = @comments.average(:rating)
    end
  end

  def edit
    if @post.user_id != @current_user.id
      flash[:errors] = "You don't have permission to edit this post."
      redirect_to :posts
    else
      @post = Post.find(params[:id])
    end
  end

  def update
    if @post.user_id != @current_user.id
      flash[:errors] = "You don't have permission to edit this post."
      redirect_to :posts
    else
      @post.update(post_params)
      if @post.save
        flash[:success] = "Algorithm updated!"
        redirect_to :post
      else 
        flash[:errors] = "Couldn'update algorithm... Please try again later"
        redirect_to :post
      end
    end
  end

  def destroy
    if @post.user_id != @current_user.id
      flash[:errors] = "You can't delete another user's posts."
      redirect_to :users
    else 
      @post.destroy
      flash[:success] = "Your algorithm was successfully deleted!"
      redirect_to :users
    end
  end

  private
    def set_post
      if Post.exists?(params[:id])
        @post = Post.find(params[:id])
      else 
        redirect_to :posts
      end
    end

    def post_params
     params.require(:post).permit(:title, :code, :description, :difficulty, :category)
    end
end
