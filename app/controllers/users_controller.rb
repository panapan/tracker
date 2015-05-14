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

  private

    def user_params
      params.require(:user).permit(:name, :email, :notify, :password,
        :password_confirmation)
    end
end
