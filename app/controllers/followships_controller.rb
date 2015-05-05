class FollowshipsController < ApplicationController
  before_action :set_user

  def create
  	@follow = Followship.new(follow_params)
  	@follow.follower_id = @user.id
    @id = follow_params[:user_id]
    @new = User.find(@id)
  	if @follow.save
  		flash[:success] = "You are now following #{@new.first_name}"
  		redirect_to :posts
  	else
  		flash[:errors] = "Something went wrong..."
  		redirect_to :posts
  	end
  end

  def destroy
	  @check = Followship.find_by(user_id: params[:id], follower_id: @user.id)
		if !@check.nil?
			@check.destroy
	  	redirect_to :posts
	  else
	  	flash[:errors] = "Something went wrong"
	  	redirect_to :posts
	  end
  end

  private
  	
  	def set_user
  		@user = User.find(session[:user_id])
  	end  	

  	def follow_params
  		params.require(:follow).permit(:user_id)
  	end
end
