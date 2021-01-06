class Api::V1::SessionsController < ApiController

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      log_in user
      params[:remember_me] == true ? remember(user) : forget(user)
      render json: { success: '200 ok' }, status: 200
    else
      render json: { error: '400 bad request' }, status: 400



end