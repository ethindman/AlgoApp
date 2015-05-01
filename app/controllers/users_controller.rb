class UsersController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @myPosts = User.find(session[:user_id]).posts
  end

  def new
  end

  # create new user and log them in
  def create
    @user = User.new
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.email = params[:email]
    @user.encrypted_password = params[:password]
    
    # get the email from URL-parameters or what have you and make lowercase
    email_address = params[:email].downcase
     
    # create the md5 hash
    hash = Digest::MD5.hexdigest(email_address)
     
    # compile URL which can be used in <img src="RIGHT_HERE"...
    image_src = "http://www.gravatar.com/avatar/#{hash}?d=retro"

    @user.gravatar = image_src
    
    if @user.save
      session[:user_id] = @user.id
      session[:signed_in] = true
      session[:first_name] = @user.first_name
      session[:last_name] = @user.last_name
      session[:gravatar] = @user.gravatar
      flash[:success] = "Login successful!"
      redirect_to :posts
    else
      flash[:errors_array] = @user.errors.full_messages
      redirect_to :mains
    end
  end

  def edit
  end

  def update
  end

  def show
    @current_user = User.find(params[:id])
    @current_user_posts = User.find(params[:id]).posts
  end

  def destroy
  end
end
