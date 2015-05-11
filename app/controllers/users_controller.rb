class UsersController < ApplicationController

  def profile
    @user = current_or_new
  end

  def save
    @user = current_or_new
    if @user.update_attributes(user_params)
      self.current_user = (@user)
      flash[:success] = "Профиль успешно сохранен"
      redirect_to root_url
    else
      render 'profile'
    end
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      self.current_user = user
      flash[:success] = "Добро пожаловать, #{user.name}!"
      redirect_to root_url
    else
      flash.now[:danger] = 'Неверная пара логин-пароль '
      @user = User.new
      render 'login_form'
    end
  end

  def logout
    self.current_user = nil
      flash[:info] = "Спасибо из использование сервиса, ждем Вас снова!"
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :notify, :password,
        :password_confirmation)
    end

    def current_or_new
      user = self.current_user
      user ||=  User.new()
    end
end
