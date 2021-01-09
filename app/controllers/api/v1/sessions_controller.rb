class Api::V1::SessionsController < ApiController

  def create
    @user = User.includes(:community_center).find_by(email: params[:email])
    if @user&.authenticate(params[:password]) && @user.activated?
      render 'create'
    else
      response_bad_request
    end
  end

end