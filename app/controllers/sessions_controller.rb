class SessionsController < ApplicationController
  before_action :return_home, only: :new

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to home_path
      else
        message = "Your account is not activated! Check your email"
        flash[:danger] = message
        redirect_to login_path
      end
    else
      flash[:danger] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
