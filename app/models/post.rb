class Post < ApplicationRecord

  belongs_to :users

  validates :body, presence: true, length: { maximum: 170 }

end
