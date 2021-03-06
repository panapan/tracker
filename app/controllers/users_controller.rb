class UsersController < ApplicationController

  def profile
    @user = self.current_or_new
  end

  def save
    @user = self.current_or_new
    if @user.update_attributes(user_params)
      self.current_user = (@user)
      flash[:success] = "Профиль успешно сохранен"
      redirect_to root_url
    else
      render 'profile'
    end
  end

  def login_form
    # redirect_to root_url 
    @user = User.new
  end

  def login
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      self.current_user.destroy unless self.current_user.nil?
      self.current_user = user
      flash[:success] = "Добро пожаловать, #{user.name}!"
      redirect_to root_url
    else
      flash.now[:danger] = 'Неверная пара логин-пароль '
      @user = User.new(user_params)
      render 'login_form'
      # flash[:danger] = 'Неверная пара логин-пароль '
      # redirect_to login_url
    end
  end

  def logout
    self.current_user = nil
    flash[:info] = "Спасибо из использование сервиса, ждем Вас снова!"
    redirect_to root_url
  end

  def recovery_form
    @user = User.new
  end

  def recovery
    user = User.find_by(email: params[:user][:email].downcase)
    if user
      recovery_code = self.recovery_token(user)
      UserMailer.send_recovery_code(user, recovery_code).deliver_now
    end
    flash[:info] = "Запрос обрабатывается, дальнейшие инструкции ищите в электронной почте"
    #{recovery_url(id: recovery_code)}
    redirect_to root_url
  end

  def new_password_form
    @token=params[:id]
    @user = User.new
  end

  def new_password
    @token = params[:token]
    @user = user_by_token(@token)
    if !@user.nil? && @user.recovery_time > 1.day.ago &&
        @user.update_attributes(user_params)
      self.current_user = (@user)
      flash[:success] = "Вход с новым паролем осуществлен"
      redirect_to root_url
    else
      @user = User.new
      render 'new_password_form'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :notify, :password,
        :password_confirmation)
    end
end
