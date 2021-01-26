class CommunityCenter < ApplicationRecord
  belongs_to :user

  has_one :community_cetner_image, dependent: :destroy
  
  has_many :posts, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :followers, through: :subscriptions, source: :user

  has_many :ad_registries, dependent: :destroy
  has_many :ads, through: :ad_registries, source: :ad
  
  scope :with_image, -> { includes(:community_center_image) }

  validates :name,
    presence: true,
    length: { maximum: 25 }

end
