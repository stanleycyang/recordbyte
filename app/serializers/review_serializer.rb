class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :body, :stars, :book
end
