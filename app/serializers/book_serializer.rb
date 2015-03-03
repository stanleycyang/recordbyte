class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :isbn13, :published_date, :thumbnail, :description
end
