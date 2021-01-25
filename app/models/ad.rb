class Ad < ApplicationRecord
  belongs_to :community_center
  has_one :ad_image, dependent: :destroy

  validates :owner_name,
    presence: true,
    length: { maximum: 30}

  validates :content,
    length: { maximum: 150 }
  
  # 半角数字で入力されていて、9桁か10桁
  # ハイフンは含まない
  # VALID_PHONE_NUMBER_REGEX = /^0\d{9,10}$/

  # validates :phone_number,
  #   format: { with: VALID_PHONE_NUMBER_REGEX }
end
