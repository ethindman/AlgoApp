class MainsController < ApplicationController
  before_action :current_user, only: [:show]

  def index
    if signed_in?
      redirect_to :posts
    end
  end

  def welcome    
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
