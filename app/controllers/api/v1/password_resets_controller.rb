class Api::V1::PasswordResetsController < ApiController
  def create
    @user = User.where(email: params[:email]).first
    if User.where(email: params[:email]).count != 0
      @user.create_reset_digest
      @user.send_reset_email
      response_success
    else
      response_unauthorized
    end
    return
  end

  def edit
    if Rails.env == 'production'
      redirect_to "https://vis-comi.com/reset_edit/#{params[:id]}"
    elsif Rails.env == 'development'
      redirect_to "http://localhost:5000/reset_edit/#{params[:id]}"
    end
    return
  end
  
  def update
    @user = User.find(params[:id])
    response_bad_request unless @user.update(user_params)
    @user.notifications.create(title: '重要なお知らせ', content: 'パスワードが再設定されました。')
    response_success
  end

  private
    def user_params
      params.require(:user).permit(:password)
    end

    def check_expiration
      return unless @user.reset_sent_at < 2.hours.ago
      if Rails.env == 'production'
        redirect_to 'https://viscomi.com/notfound'
      elsif Rails.env == 'development'
        redirect_to 'http://localhost:5000/notfound'
      end
    end
end
