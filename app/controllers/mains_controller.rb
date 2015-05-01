class MainsController < ApplicationController
  def index
    if session[:signed_in] == true
      redirect_to :posts
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @posts
    if params[:search]
      @posts = Post.where("title LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @posts = Post.where("category LIKE ?", "%#{params[:id]}%")
    end
  end

  def destroy
  end
end
