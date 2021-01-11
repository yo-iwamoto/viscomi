class CommunityCenter < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_one_attached :image

  validates :name,
    presence: true,
    length: { maximum: 25 }

  validates :image,
    content_type: {
      in: %w[image/jpeg image/gif image/png],
      message: "jpg、gif、png形式のものを利用してください。"
    },
    size: {
      less_than: 5.megabytes,
      message: "5MB以下のファイルを利用してください。"
    }

  def small_image
    image.variant(resize_to_fill: [120, 120])
  end

  def big_image
    image.variant(resize_to_limit: [300, 300])
  end
end
