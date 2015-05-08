class SessionsController < ApplicationController
  before_action :require_logged_in, only: [:index, :destroy]

  def new
  end

  #login
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil? 
      flash[:errors] = "Invalid Email or Password"
      redirect_to :mains
    else 
      sign_in user
      redirect_to :posts
    end
  end

  #logout
  def destroy
    sign_out
    redirect_to :mains
  end
  
end
