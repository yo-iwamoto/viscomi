class Api::V1::AccountActivationsController < ApiController
  def edit
    user = User.find_by!(email: params[:email])
    return unless user&.authenticated?(:activation, params[:id]) && !user.activated?
    user.activate
    if Rails.env == 'production'
      redirect_to 'https://viscomi.herokuapp.com/login'
    elsif Rails.env == 'development'
      redirect_to 'http://localhost:5000/login'
    end
  end
end
