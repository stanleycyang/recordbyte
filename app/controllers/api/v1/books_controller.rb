class API::V1::BooksController < ApplicationController

  protect_from_forgery with: :null_session

  respond_to :json, :html, :xml

  before_action :restrict_access

  def index
    respond_with Book.all, default_serializer_options
  end

  def show
    respond_with Book.find(params[:id])
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: book, status: 201
    else
      render json: {errors: book.errors}, status: 422
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      render json: book, status: 200
    else
      render json: {errors: book.errors}, status: 422
    end
  end

  def destroy
    book = book.find(params[:id])
    book.destroy
    head 204
  end

  private

    def book_params
      params.require(:book).permit(:author, :title, :isbn13, :published_date, :thumbnail, :description)
    end
end
