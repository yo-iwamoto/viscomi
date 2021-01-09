class User < ApplicationRecord
  attr_accessor :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  has_secure_password
  has_one :community_center

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

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def activate
    update_attribute(:activated, true)
  end
  
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def new_community_center(community_center_name)
    update_attribute(:is_manager, true)
    create_community_center(name: community_center_name)
  end

  private

    def downcase_email
      self.email.downcase!
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
