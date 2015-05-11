def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit login_path
    fill_in "Email",    with: user.email
    fill_in "Пароль", with: user.password
    click_button "Войти"
  end
end

def change_profile(options={})
  if options[:no_capybara]
    # not using Capybara.
  else
    visit profile_path
    fill_in "Имя",            with: "Name"
    fill_in "Email",          with: "test@test.com"
    fill_in "Пароль",         with: "password"
    fill_in "Подтверждение",  with: "password"
    click_button "Сохранить"
  end
end
