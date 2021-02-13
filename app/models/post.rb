class Post < ApplicationRecord
  belongs_to :community_center
  # 'type'はActiveRecordが利用する特別なカラム名なので、その解釈を回避
  self.inheritance_column = :_type_disabled

  has_one :post_image, dependent: :destroy

  default_scope { order(created_at: :desc) }
  default_scope { includes(:post_image) }

  validates :title,
    presence: true,
    length: { maximum: 30 }

  validates :content,
    presence: true,
    length: { maximum: 3000 }

end
