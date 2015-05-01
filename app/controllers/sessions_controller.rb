class SessionsController < ApplicationController
  def index
  end

  def new
  end

  #login
  def create
    @user = User.find_by(
      :email => params[:email], 
      :encrypted_password => params[:password]
    )
    if @user
      session[:user_id] = @user.id
      session[:signed_in] = true
      session[:first_name] = @user.first_name
      session[:last_name] = @user.last_name
      session[:gravatar] = @user.gravatar
      flash[:success] = "Login successful!"
      redirect_to :posts
    else
      flash[:errors] = "Invalid email or password"
      redirect_to :mains
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
    reset_session
    redirect_to :mains
  end
end
