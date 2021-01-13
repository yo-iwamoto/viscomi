class Post < ApplicationRecord
  belongs_to :community_center
  self.inheritance_column = :_type_disabled

  has_one :post_image, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :title,
    length: {
      minimum: 2,
      maximum: 25
    }

  def formatted_date
    return created_at.strftime("%m月 %d日 %T")
  end

end
