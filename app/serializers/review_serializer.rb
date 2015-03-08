class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :body, :stars, :poster, :book

  has_one :book

  def poster
    return {id: object.user.id, name: object.user.name}
  end

end
