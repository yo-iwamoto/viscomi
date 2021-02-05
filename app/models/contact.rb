class Contact < ApplicationRecord
  belongs_to :community_center

  has_one :contact_image

  validates :subject,
    presence: true,
    length: {
      maximum: 50
    }

  validates :content,
    presence: true,
    length: {
      maximum: 1000
    }

  default_scope { order(created_at: :desc) }

  def sent_at_formatted
    sent_at&.strftime("%m月 %d日")
  end

  def image
    contact_image&.image
  end
end
