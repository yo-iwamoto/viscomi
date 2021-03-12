class FeedbackMailer < ApplicationMailer

  def feedback(feedback, user)
    @user = user
    @feedback = feedback
    mail to: 'viscomi1040@gmail.com', subject: @feedback.title
  end

end
