class API::V1::ReviewsController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :restrict_access

  respond_to :html, :xml, :json

  def index
    respond_with Review.all, default_serializer_options
  end

  def show
    respond_with Review.find(params[:id])
  end

  def create
    review = Review.new(review_params)
    user = User.find_by_access_token(params[:access_token])
    review.user = user

    if review.save
      render json: review, status: 201
    else
      render json: {errors: review.errors}, status: 422
    end
  end

  def update
    review = Review.find(params[:id])
    if review.update(review_params)
      render json: review, status: 200
    else
      render json: {errors: review.errors}, status: 422
    end
  end

  private

    def review_params
      params.require(:review).permit(:body, :user_id, :book_id, :stars, :access_token)
    end

end
