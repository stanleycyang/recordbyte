class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :body, :stars, :book, :user

  has_one :book

end
