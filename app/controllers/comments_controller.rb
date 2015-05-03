class CommentsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @comment = Comment.create( comment_params )
    if @comment.save
      flash[:success] = "Comment successfully posted!"
      redirect_to "/posts/#{params[:post][:post_id]}"
    else
      flash[:errors_array] = @comment.errors.full_messages
      redirect_to "/posts/#{params[:post][:post_id]}"
    end
  end

  def show
    render html: "TOG HERE"
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    if @comment.user_id == session[:user_id] || @post.user_id == session[:user_id]
      @comment.destroy 
      flash[:success] = "Comment deleted!"
      redirect_to "/posts/#{@comment.post_id}"
    else
      flash[:errors] = "You can only delete your own comments"
      redirect_to "/posts/#{@comment.post_id}"
    end
  end

  def edit
  end

  def update
  end
  
  private 
  def comment_params
   params.require(:post).permit(:comment, :post_id, :user_id)
  end
  
end
