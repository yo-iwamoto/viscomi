class Api::V1::AccountActivationsController < ApiController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
    end
    redirect_to 'http://localhost:3000/login' if Rails.env == "development"
    redirect_to 'https://viscomi.herokuapp.com/login' if Rails.env == "production"

  end
end
