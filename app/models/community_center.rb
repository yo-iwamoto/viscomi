class CommunityCenter < ApplicationRecord
  belongs_to :user

  has_one :community_center_image, dependent: :destroy
  
  has_many :posts, dependent: :destroy

  has_many :contacts, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :followers, through: :subscriptions, source: :user

  has_many :ad_registries, dependent: :destroy
  has_many :ads, through: :ad_registries, source: :ad
  
  scope :with_image, -> { includes(:community_center_image) }

  validates :name,
    presence: true,
    length: { maximum: 30 }

  validates :comment,
    length: { maximum: 500 }

  def send_contact(contact)
    followers.each do |follower|
      next if follower.mute_contact
      CommunityCenterMailer.contact(contact, follower).deliver_now
    end
  end
end
