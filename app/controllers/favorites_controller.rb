class FavoritesController < ApplicationController
  before_action :set_user

  def create
  	@check = Favorite.find_by(post_id: @post_id, user_id: @user.id)
  	if @check
  		flash[:errors] = "already liked!"
			redirect_to(:back)
  	else
	  	@like = Favorite.new(favorite_params)
	  	@like.user_id = @user.id
	  	if @like.save
	  		redirect_to(:back)
	  	else 
	  		flash[:errors] = "Something went wrong. Please try again later"
	  		redirect_to(:back)
	  	end
	  end
  end

  def destroy
    @check = Favorite.find_by(post_id: params[:id], user_id: @user.id )
    if !@check.nil?
      @check.destroy
    	redirect_to(:back)
    else 
      flash[:errors] = "Something went wrong.."
      redirect_to(:back)
    end
  end

  private
  
  	def set_user
  		@user = User.select("id, first_name, last_name, belts, gravatar, summary, created_at").find(session[:user_id])
  	end

  	def favorite_params
  		params.require(:favorite).permit(:post_id)
  	end

end
