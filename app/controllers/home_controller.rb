class HomeController < ApplicationController
  before_action :logged_in_user, only: :home
  before_action :return_home, only: :index

  def index
  end

  def home
  end

  def about
  end

  def terms
  end

  def privacy
  end
end
