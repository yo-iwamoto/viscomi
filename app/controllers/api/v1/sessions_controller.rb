class Api::V1::SessionsController < ApiController
  include ActionController::Cookies

  def create
    @user = User.includes(:community_center).find_by(email: params[:email])
    response_bad_request if @user.nil?
    if !@user.activated?
      render status: 400, json: { status: 400, message: 'Unactivated Account' }
    elsif !@user.authenticate(params[:password])
      response_unauthorized
    else
      # payload = { uid: @user.id }
      # token = JWT.encode, nil, 'none'
      # response.headers['access-token'] = token
      log_in @user
    end
  end

  def destroy
    log_out if logged_in?
    response_success
  end
end