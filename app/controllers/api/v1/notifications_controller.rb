class Api::V1::NotificationsController < ApiController
  before_action :authenticate_user?, only: %i[show update]
  before_action :correct_user?, only: %i[show update]

  def show
    @notifications = current_user.notifications
  end

  def update
    @notifications = current_user.notifications
    @notifications.each do |n|
      n.update(read: true)
    end
    response_success
  end

  private

    def correct_user?
      user = User.find(params[:id])
      response_bad_request unless current_user == user
    end
end
