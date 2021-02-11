class Feedback < ApplicationRecord
  belongs_to :user

  validates :title,
    length: { maximum: 30 }

  validates :content,
    length: { maximum: 3000 }

  def send_feedback(user)
    FeedbackMailer.feedback(self, user).deliver_now
  end
end
