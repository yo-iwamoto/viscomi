class Api::V1::SessionsController < ApiController

  def create
    @user = User.find_by!(email: params[:email])
    if @user.nil? || !@user.authenticate(params[:password])
      render status: 400, json: { message: '入力情報に誤りがあります。情報をお確かめの上、再度お試しください。'}
    elsif !@user.activated?
      render status: 400, json: { message: 'アカウントが有効化されていません。メールをご確認ください。' }
    else
      payload = { uid: @user.id }
      token = JWT.encode payload, nil, 'none'
      response.set_header('Access-Token', token)
    end
  end
end