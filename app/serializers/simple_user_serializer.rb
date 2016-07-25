class SimpleUserSerializer < ActiveModel::Serializer

  attributes :id, :username, :email, :avatar, :followees_count, :followers_count, :created_at

  def followees
    object.followees(User)
  end

  def followers
    object.followers(User)
  end

  has_many :followees, serializer: UserListSerializer
  has_many :followers, serializer: UserListSerializer
  has_many :posts


end
