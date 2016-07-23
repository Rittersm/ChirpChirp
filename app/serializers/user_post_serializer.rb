class UserPostSerializer < ActiveModel::Serializer

  attributes :id, :username, :email, :avatar, :created_at, :followees

  def followees
    object.followees(User)
  end

  has_many :followees
  has_many :timeline_posts


end
