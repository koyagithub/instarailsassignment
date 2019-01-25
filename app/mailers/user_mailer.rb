class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @url  = "https://c1c7ceff64084c3695ace0352d372104.vfs.cloud9.us-east-2.amazonaws.com/users/#{user.activation_token}/activate"
    mail(to: user.email, subject: "Account activation")
  end

  def activation_success_email(user)
    @user = user
    @url  = "https://c1c7ceff64084c3695ace0352d372104.vfs.cloud9.us-east-2.amazonaws.com/users/#{user.activation_token}/activate"
    mail(to: user.email, subject: "Your account is now activated")
  end
end
