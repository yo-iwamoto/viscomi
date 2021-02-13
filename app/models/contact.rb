class Contact < ApplicationRecord
  belongs_to :community_center

  has_one :contact_image

  validates :subject,
    presence: true,
    length: { maximum: 30 }

  validates :content,
    presence: true,
    length: { maximum: 3000 }

  default_scope { order(created_at: :desc) }
end
