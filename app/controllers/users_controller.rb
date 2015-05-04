class UsersController < ApplicationController
  before_action :set_user, only: [:index, :edit, :update, :destroy, :favorite]

  def index
    @myPosts = @user.posts
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
    if @user.update(profile_params)
      flash[:success] = "Profile updated!"
      session[:first_name] = @user.first_name
      session[:last_name] = @user.last_name
      redirect_to :users
    else
      flash[:errors] = "Something went wrong... Please try again later."
      redirect_to :users
    end
  end

  def show
    if User.exists?(params[:id])
      @current_user = User.find(params[:id])
      @current_user_posts = User.find(params[:id]).posts
    else
      flash[:errors] = "Couldn't find selected user."
      redirect_to :posts
    end
  end

  def destroy
  end

  def favorite
    @favorites = @user.favorite_posts

    @favorites += "," +params[:id]

    @user.update(favorite_posts: @favorites)
    

    redirect_to :post
    flash[:success] = "Algorithm added to favorites!"
  end 

  private
    def set_user
      @user = User.find(session[:user_id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :gravatar)
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :belts, :summary)
    end

end
