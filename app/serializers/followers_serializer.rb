class FollowersSerializer < ActiveModel::Serializer

  attributes :id, :username, :email, :avatar, :followees_count, :followers_count, :created_at

  def followers
    object.followers(User)
  end

  has_many :followers

end
