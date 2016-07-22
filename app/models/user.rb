class User < ApplicationRecord

  has_many :posts
  acts_as_followable
  acts_as_follower

  has_secure_password

  validates :username, presence: true, uniqueness: true, format: {:with => /\A[a-zA-Z0-9\-_]+\z/}
  validates :email, presence: true, uniqueness: true, format: {:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}
  validates :avatar, presence: true
  validates :api_token, presence: true, uniqueness: true

  before_validation :generate_api_token, on: :create

  private

  def generate_api_token
    while api_token.blank? || User.exists?(api_token: api_token)
      self.api_token = SecureRandom.hex(20)
    end
  end
end
