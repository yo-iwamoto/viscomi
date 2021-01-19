class Post < ApplicationRecord
  belongs_to :community_center
  self.inheritance_column = :_type_disabled

  has_one :post_image, dependent: :destroy

  default_scope { order(created_at: :desc) }
  scope :with_image, -> { includes(:post_image) }

  validates :title,
    length: {
      minimum: 2,
      maximum: 25
    }

  def formatted_date
    return created_at.strftime("%m月 %d日 %T")
  end

  def image
    self.post_image.image
  end

end
