class Post < ApplicationRecord
  belongs_to :community_center
  self.inheritance_column = :_type_disabled

  has_one_attached :image

  default_scope -> { order(created_at: :desc) }

  validates :title,
    length: {
      minimum: 2,
      maximum: 25
    }

  validates :image,
    content_type: {
      in: %w[image/jpeg image/gif image/png],
      message: "jpg、gif、png形式のものを利用してください。"
    },
    size: {
      less_than: 5.megabytes,
      message: "5MB以下のファイルを利用してください。"
    }

  include Rails.application.routes.url_helpers
  def image_url
    image.attached? ? url_for(image) : nil
  end

  def small_image
    image.variant(resize_to_fill: [120, 120])
  end

  def big_image
    image.variant(resize_to_limit: [300, 300])
  end
end
