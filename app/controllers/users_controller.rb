class UsersController < ApplicationController
  before_action :current_user
  before_action :require_signed_in, except: [:create]

  def index
    @users = User.all.where.not(id: session[:user_id]).order(created_at: "DESC").paginate(page: params[:page], per_page: 15)
    @followships = Followship.all
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
      flash[:success] = "Thank you for registering! Please enjoy the app!"
      redirect_to :welcome
    else
      flash[:errors_array] = @user.errors.full_messages
      redirect_to :mains
    end
  end

  def show
    if User.exists?(params[:id])
      @user = User.select("id, first_name, last_name, belts, gravatar, summary, created_at").find(params[:id])
      @user_posts = @user.posts
      @followers = @user.inverse_followships
      @following = @user.inverse_followships.where(user_id: @current_user.id)
    else
      flash[:errors] = "Couldn't find selected user."
      redirect_to :posts
    end
  end

  def change_password  
  end

  def update_password
    if password_params[:new_password] != password_params[:confirmation]
      flash[:errors] = "New Password and Confirm Password Fields do not match. Please try again."
      redirect_to(:back)
    else
      user = User.authenticate(@current_user.email, password_params[:curr_password])
      if user.nil? 
        flash[:errors] = "Current Password field does not match records."
        redirect_to(:back)
      else 
        hash_key = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password_params[:new_password]}")
        pass = Digest::SHA2.hexdigest("#{hash_key}--#{password_params[:new_password]}")
        user.update(encrypted_password: pass, hash_key: hash_key)
        flash[:success] = "Password Succesffully Updated!"
        redirect_to(:back)
      end
    end
  end

  def edit
  end

  def update
    if @current_user.update(profile_params)
      flash[:success] = "Profile updated!"
      session[:user_name] = [@current_user.first_name, @current_user.last_name].join(" ")
      redirect_to :users
    else
      flash[:errors] = "Something went wrong... Please try again later."
      redirect_to :users
    end
  end

  def destroy
  end

  def profile
    @myPosts = @current_user.posts
    @myFavorites = @current_user.favorites.includes(:post).includes(:user)
    @friends = @current_user.followers
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :gravatar)
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :belts, :summary)
    end

    def password_params
      params.require(:password).permit(:curr_password, :new_password, :confirmation)
    end

end
