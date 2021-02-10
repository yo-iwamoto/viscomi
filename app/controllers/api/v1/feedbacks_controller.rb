class Api::V1::FeedbacksController < ApiController
  def create
    feedback = current_user.feedbacks.create(feedback_params)
    response_bad_request unless feedback.save
    feedback.send_feedback(current_user)
    response_success
  end

  private

    def feedback_params
      params.require(:feedback).permit(:title, :content)
    end
end
