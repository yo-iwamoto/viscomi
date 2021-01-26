class Api::V1::AccountActivationsController < ApiController
  def edit
    user = User.find_by!(email: params[:email])
    return unless user&.authenticated?(:activation, params[:id]) && !user.activated?
    user.activate
  end
end
