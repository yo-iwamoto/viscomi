class Api::V1::NotificationsController < ApiController
  before_action :authenticate_user?, only: %i[show]

  def show
    @notifications = current_user.notifications
  end
end
