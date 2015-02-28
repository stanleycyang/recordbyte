class UsersController < ApplicationController

  before_action :return_home, only: :new

  def show
    User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      log_in @user
      flash[:success] = "Thanks for registering! Please check your email to activate your account"
      redirect_to "#{home_path}/"
    else
      flash[:danger] = "Invalid registration"
      redirect_to signup_path
    end
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
