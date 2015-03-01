class API::V1::CommentsController < ApplicationController
  protect_from_forgery with: :null_session

  # Makes sure the person has an access token first
  before_action :restrict_access

  respond_to :html, :xml, :json

  def index
    respond_with Comment.all, default_serializer_options
  end

  def show
    respond_with Comment.find(params[:id])
  end

  def create
    comment = Comment.new(comment_params)

    # Get the user through the access token
    user = User.find_by_access_token(params[:access_token])
    comment.user = user

    if comment.save
      render json: comment, status: 201
    else
      render json: {errors: comment.errors}, status: 422
    end

  end

  def update
    comment = Comment.find(params[:id])
    if Comment.update(comment_params)
      render json: comment, status: 200
    else
      render json: {errors: comment.errors}, status: 422
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    head 204
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :user_id, :review_id, :access_token)
    end
end
