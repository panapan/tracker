class UsersController < ApplicationController

  def profile
    self.current_user ||=  User.new()
  end

  def save
    if self.current_user.update_attributes(user_params)
      # self.current_user=(@user)
      flash[:success] = "Профиль обновлен"
      redirect_to root_url
    else
      render 'profile'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :notify, :password,
        :password_confirmation)
    end
end
