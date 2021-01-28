class Post < ApplicationRecord
  belongs_to :community_center
  # 'type'はActiveRecordが利用する特別なカラム名なので、その解釈を回避
  self.inheritance_column = :_type_disabled

  has_one :post_image, dependent: :destroy

  default_scope { order(created_at: :desc) }
  default_scope { includes(:post_image) }

  validates :title,
    length: {
      minimum: 2,
      maximum: 25
    }

  validates :content,
    length: {
      minimum: 2,
      maximum: 1000
    }

  def formatted_date
    return created_at.strftime("%m月 %d日")
  end

  def image
    post_image&.image
  end

end
