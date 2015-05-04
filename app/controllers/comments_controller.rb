class CommentsController < ApplicationController

  def create
    @post_id = params[:post][:post_id]
    @user_id = session[:user_id]

    alreadyPosted = Comment.findComment(@post_id, @user_id)

    if alreadyPosted
      flash[:errors] = "Looks like you already reviewed this algorithm. Please find and delete your review to post again."
      redirect_to "/posts/#{params[:post][:post_id]}"
    else 
      @comment = Comment.new(comment_params)
      @comment.user_id = session[:user_id]
      if @comment.save
        flash[:success] = "Review successfully posted!"
        redirect_to "/posts/#{params[:post][:post_id]}"
      else
        flash[:errors_array] = @comment.errors.full_messages
        redirect_to "/posts/#{params[:post][:post_id]}"
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    if @comment.user_id == session[:user_id] || @post.user_id == session[:user_id]
      @comment.destroy 
      flash[:success] = "Your review was deleted!"
      redirect_to "/posts/#{@comment.post_id}"
    else
      flash[:errors] = "You can only delete your own comments"
      redirect_to :posts
    end
  end
  
  private 
  def comment_params
   params.require(:post).permit(:comment, :rating, :post_id)
  end
  
end
