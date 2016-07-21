class PostSerializer < ActiveModel::Serializer
  attributes :body, :created_at

  belongs_to :user
end
