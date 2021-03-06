class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user

  validates :review_id, presence: true
  validates :user_id, presence: true
  validates :body, presence: true, length: {maximum: 140}
end
