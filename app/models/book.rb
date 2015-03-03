class Book < ActiveRecord::Base
  has_many :reviews
  has_many :users, through: :reviews

  serialize :author, Array

  #validates :title, presence: true
  #validates :author, presence: true
  #validates :isbn13, presence: true
  #validates :published_date, presence: true
  #validates :thumbnail, presence: true
  #validates :description, presence: true
end
