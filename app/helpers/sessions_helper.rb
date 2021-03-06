module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session: 1. calls user remember method 2. hashed secure cookie for user.id 3. user's remember token
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forget a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end


  # Get the current logged in user
  def current_user
   if(user_id = session[:user_id])
     @current_user ||= User.find_by(id: user_id)
   elsif(user_id = cookies.signed[:user_id])
     user = User.find_by(id: user_id)
     if user && user.authenticated?(:remember, cookies[:remember_token])
       log_in user
       @current_user = user
     end
   end
  end

  def logged_in?
    !current_user.nil?
  end

  # Destroy the session
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in!"
      redirect_to login_url
    end
  end

  def return_home
    if logged_in?
      redirect_to home_url
    end
  end

end
