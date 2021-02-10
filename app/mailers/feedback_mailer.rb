class FeedbackMailer < ApplicationMailer

  def feedback(feedback, user)
    @user = user
    @feedback = feedback
    mail to: 'viscomi.auth@gmail.com', subject: @feedback.title
  end

end
