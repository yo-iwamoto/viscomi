class Post < ApplicationRecord
  belongs_to :community_center
  self.inheritance_column = :_type_disabled

  has_one :post_image

  default_scope -> { order(created_at: :desc) }

  validates :title,
    length: {
      minimum: 2,
      maximum: 25
    }

end
