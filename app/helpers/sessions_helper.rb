module SessionsHelper

  # 渡されたユーザーでログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  # ログイン情報をCookieに保存
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  # セッション情報を破棄
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # ログイン中のユーザー
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーをログアウト
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
end