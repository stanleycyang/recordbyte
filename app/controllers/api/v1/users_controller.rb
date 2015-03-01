class API::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json, :xml, :html
  before_action :restrict_access

  def show
    respond_with User.find_by_access_token(params[:access_token])
  end

  def update
    user = User.find_by_access_token(params[:access_token])
    if user.update(user_params)
      render json: user, status: 200
    else
      render json: {errors: user.errors}, status: 422
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
