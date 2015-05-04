class FavoritesController < ApplicationController
  before_action :set_user

  def create
  	@post_id = params[:favorite][:post_id]
  	@check = Favorite.find_by(post_id: @post_id, user_id: @user.id)
  	if @check
  		flash[:errors] = "already liked!"
			redirect_to "/posts/#{@post_id}"
  	else
	  	@like = Favorite.new(favorite_params)
	  	@like.user_id = @user.id
	  	if @like.save
	  		redirect_to "/posts/#{@post_id}"
	  	else 
	  		flash[:errors] = "Something went wrong. Please try again later"
	  		redirect_to "/posts/#{@post_id}"
	  	end
	  end
  end

  def destroy
  	Favorite.find(params[:id]).destroy
  	redirect_to "/posts/#{params[:favorite][:post_id]}"
  end

  private
  	
  	def set_user
  		@user = User.find(session[:user_id])
  	end  	

  	def favorite_params
  		params.require(:favorite).permit(:post_id)
  	end

end
