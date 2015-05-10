class UsersController < ApplicationController
  before_action :current_user
  before_action :require_signed_in, except: [:create]

  def index
    @myPosts = @current_user.posts
    @myFavorites = @current_user.favorites.includes(:post).includes(:user)
    @myFollowers = @current_user.followships
    @myFriends = Followship.where(follower_id: @current_user.id).includes(:user)
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
      sign_in @user
      flash[:success] = "Login successful!"
      redirect_to :posts
    else
      flash[:errors_array] = @user.errors.full_messages
      redirect_to :mains
    end
  end

  def show
    if User.exists?(params[:id])
      @user = User.select("id, first_name, last_name, belts, gravatar, summary, created_at").find(params[:id])
      @user_posts = @user.posts
      @followers = @user.followships
      @following = @user.followships.find_by(follower_id: @current_user.id)
    else
      flash[:errors] = "Couldn't find selected user."
      redirect_to :posts
    end
  end

  def edit
  end

  def update
    if @current_user.update(profile_params)
      flash[:success] = "Profile updated!"
      session[:first_name] = @current_user.first_name
      session[:last_name] = @current_user.last_name
      redirect_to :users
    else
      flash[:success] = "Something went wrong... Please try again later."
      redirect_to :users
    end
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :gravatar)
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :belts, :summary)
    end

end
