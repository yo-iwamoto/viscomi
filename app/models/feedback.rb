class Feedback < ApplicationRecord
  belongs_to :user

  def send_feedback(user)
    FeedbackMailer.feedback(self, user).deliver_now
  end
end
