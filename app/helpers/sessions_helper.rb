module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    session[:user_name] = [user.first_name, user.last_name].join(" ")
    session[:gravatar] = user.gravatar
    self.current_user = user
  end
  
  # setter method
  def current_user=(user)
    @current_user = user
  end

  # getter method
  def current_user
    @current_user ||= User.select("id, first_name, last_name, email, belts, summary, gravatar, created_at").find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    reset_session
    self.current_user = nil
  end

  def current_user?(user)
    user == current_user 
  end

  def deny_access
    flash[:errors] = "Please sign in to access this page."
    redirect_to :mains
  end

  def require_signed_in
    if !signed_in?
      deny_access
    end
  end
end