class FollowshipsController < ApplicationController
  before_action :current_user
  before_action :require_signed_in

  def create
    @follow = @current_user.followships.build(follower_id: follow_params[:user_id])
    @id = follow_params[:user_id]
    @thisUser = User.find(@id)
  	if @follow.save
  		flash[:success] = "You are now following #{@thisUser.first_name}"
  		redirect_to(:back)
  	else
  		flash[:errors] = "Something went wrong..."
  		redirect_to(:back)
  	end
  end

  def destroy
	  @followship = @current_user.followships.find_by(follower_id: params[:id])
	  @thisUser = User.find(params[:id])
		if !@followship.nil?
			@followship.destroy
			flash[:success] = "You have unfollowed #{@thisUser.first_name}"
	  	redirect_to(:back)
	  else
	  	flash[:errors] = "Something went wrong.."
	  	redirect_to(:back)
	  end
  end

  private
  	def follow_params
  		params.require(:follow).permit(:user_id)
  	end
end
