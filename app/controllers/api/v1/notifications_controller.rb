class Api::V1::NotificationsController < ApiController
  before_action :authenticate_user?, only: %i[show]
  before_action :correct_user?, only: %i[show]

  def show
    @notifications = current_user.notifications
  end

  private

    def correct_user?
      user = User.find(params[:id])
      response_bad_request unless current_user == user
    end
end
