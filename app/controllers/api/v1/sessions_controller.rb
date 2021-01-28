class Api::V1::SessionsController < ApiController
  include ActionController::Cookies

  def create
    @user = User.includes(:community_center).find_by(email: params[:email])
    if @user.nil?
      render status: 400, json: { message: '入力情報に誤りがあります。情報をお確かめの上、再度お試しください。'}
    elsif !@user.activated?
      render status: 400, json: { message: 'Unactivated Account' }
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