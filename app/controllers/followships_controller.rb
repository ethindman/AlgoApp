class FollowshipsController < ApplicationController
  before_action :current_user

  def create
  	@follow = Followship.new(follow_params)
  	@follow.follower_id = @current_user.id
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
	  @check = Followship.find_by(user_id: params[:id], follower_id: @current_user.id)
	  @thisUser = User.find(params[:id])
		if !@check.nil?
			@check.destroy
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
