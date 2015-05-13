class MainsController < ApplicationController
  before_action :current_user, only: [:show, :all_users]

  def index
    if signed_in?
      redirect_to :posts
    end
  end

  def welcome 
  end

  def all_users
    @users = User.all.where.not(id: session[:user_id]).order(created_at: "DESC").paginate(page: params[:page], per_page: 15)
    @followships = Followship.all
  end

  def show
    @followships = Followship.all
    if params[:search]
      @posts = Post.where("title LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @posts = Post.where("category LIKE ?", "%#{params[:id]}%")
    end
  end
end
