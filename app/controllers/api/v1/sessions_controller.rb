class Api::V1::SessionsController < ApiController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      log_in user
      params[:remember_me] == true ? remember(user) : forget(user)
    else
      render response_bad_request
    end
  end

  def destroy 
    log_out if logged_in?
    redirect_to root_url
  end

end