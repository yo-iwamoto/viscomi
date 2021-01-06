class User < ApplicationRecord
  before_save :downcase_email

  has_secure_password
  has_one_attached :image

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,
    presence: true,
    length: { maximum: 25 }

  validates :password,
    presence: true,
    length: { minimum: 6 },
    allow_nil: true

  validates :email,
  presence: true,
  length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: true

  validates :image,
    content_type: {
      in: %w[image/jpeg image/gif image/png],
      message: "jpg、gif、png形式のものを利用してください。"
    },
    size: {
      less_than: 5.megabytes,
      message: "5MB以下のファイルを利用してください。"
    }

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute( remember_digest: User.digest(remember_token) )
  end

  def forget
    update_attribute( remember_digest: nil )
  end

  def activate
    update_columns(
      activated: true,
      activated_at: Time.zone.now
    )
  end

  private

    def downcase_email
      self.email.downcase!
    end
end
