class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "ビズコミ アカウント認証のお願い"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "ビズコミ パスワード再設定のお知らせ"
  end
  
end
