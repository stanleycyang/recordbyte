class PasswordResetsController < ApplicationController

  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email has been sent regarding the password reset"
      redirect_to login_path
    else
      flash[:danger] = "Email address was not found"
      redirect_to new_password_reset_path
    end
  end

  def edit
  end

  def update
    if password_blank?
      flash[:danger] = "Password can't be blank"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = 'Password has been reset'
      redirect_to login_path
    else
      flash[:danger] = "Invalid password"
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def password_blank?
      params[:user][:password].blank?
    end

    # Filters

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless(@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired"
        redirect_to new_password_reset_path
      end
    end
end
