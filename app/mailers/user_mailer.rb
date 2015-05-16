class UserMailer < ApplicationMailer
  def send_recovery_code(user, recovery_code)
    @user = user
    @code = recovery_code
    mail(to: @user.email, subject: 'Cмена пароля')
  end

  def send_status (parcel)
    @user = parcel.user
    @parcel = parcel
    @track = parcel.tracks.last
    mail(to: @user.email, subject: 'Изменение статуса посылки')
  end
end