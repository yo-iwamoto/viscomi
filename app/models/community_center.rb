class CommunityCenter < ApplicationRecord
  belongs_to :user

  has_one :community_cetner_image, dependent: :destroy
  
  has_many :posts, dependent: :destroy

  has_many :subscriptions, foreign_key: "followed_id", dependent: :destroy

  has_many :followers, through: :subscriptions, source: :follower

  has_many :ads, dependent: :destroy
  
  scope :with_image, -> { includes(:community_center_image) }

  validates :name,
    presence: true,
    length: { maximum: 25 }

end
