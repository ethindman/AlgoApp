class SessionsController < ApplicationController

  def new
  end

  #login
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil? 
      flash[:errors] = "Invalid Email or Password"
      redirect_to :mains
    else 
      session[:user_id] = user.id
      session[:signed_in] = true
      session[:first_name] = user.first_name
      session[:last_name] = user.last_name
      session[:gravatar] = user.gravatar
      redirect_to :posts
    end
  end

  #logout
  def destroy
    reset_session
    redirect_to :mains
  end
  
end
