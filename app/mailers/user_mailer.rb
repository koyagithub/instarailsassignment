class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @url  = "https://c1c7ceff64084c3695ace0352d372104.vfs.cloud9.us-east-2.amazonaws.com/users/#{user.activation_token}/activate"
    mail(to: user.email, subject: "KOYAGRAM アカウント有効化メール")
  end

  def activation_success_email(user)
    @user = user
    @url  = "https://c1c7ceff64084c3695ace0352d372104.vfs.cloud9.us-east-2.amazonaws.com/users/#{user.activation_token}/activate"
    mail(to: user.email, subject: "KOYAGRAM アカウントが有効化されました")
  end
  
  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(:to => user.email,
         :subject => "KOYAGRAM パスワード再設定メール")
  end
end
