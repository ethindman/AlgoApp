class UsersController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @myPosts = User.find(session[:user_id]).posts
  end

  def new
  end

  # create new user and log them in
  def create
    @user = User.new(user_params)
    #create gravatar
    email_address = params[:user][:email].downcase
    hash = Digest::MD5.hexdigest(email_address)
    image_src = "http://www.gravatar.com/avatar/#{hash}?d=retro"
    @user.gravatar = image_src
    
    if @user.save
      session[:signed_in] = true
      session[:user_id] = @user.id
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

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :gravatar)
    end

end
