class UserMailer < ApplicationMailer
  def send_recovery_code(user, recovery_code)
    @user = user
    @code = recovery_code
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Смена пароля Postracker')
  end
end
