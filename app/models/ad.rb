class Ad < ApplicationRecord
  has_one  :ad_image,      dependent: :destroy

  has_many :ad_registries, dependent: :destroy
  has_many :community_centers, through: :ad_registries, source: :community_center

  default_scope { order(created_at: :desc) }
  default_scope { includes(:ad_image) }

  validates :owner_name,
    presence: true,
    length: { maximum: 30 }

  validates :content,
    presence: true,
    length: { maximum: 3000 }

  def image
    ad_image&.image
  end
  
  # 半角数字で入力されていて、9桁か10桁
  # ハイフンは含まない
  # VALID_PHONE_NUMBER_REGEX = /^0\d{9,10}$/

  # validates :phone_number,
  #   format: { with: VALID_PHONE_NUMBER_REGEX }
end
