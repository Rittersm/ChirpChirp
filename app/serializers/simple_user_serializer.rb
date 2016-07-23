class SimpleUserSerializer < ActiveModel::Serializer

  attributes :id, :username, :email, :avatar, :followees_count, :followers_count, :created_at, :followees, :followers

  def followees
    object.followees(User)
  end

  def followers
    object.followers(User)
  end

  has_many :followees
  has_many :followers
  has_many :posts


end
