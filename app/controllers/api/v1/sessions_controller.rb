class Api::V1::SessionsController < ApiController

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      render json: @user
    else
      response_bad_request
    end
  end

  def destroy 
    log_out if logged_in?
    redirect_to root_url
  end

end