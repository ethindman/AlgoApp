class MainsController < ApplicationController
  def index
    if signed_in?
      redirect_to :posts
    end
  end

  def show
    @posts
    if params[:search]
      @posts = Post.where("title LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @posts = Post.where("category LIKE ?", "%#{params[:id]}%")
    end
  end
end
