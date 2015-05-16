require 'rails_helper'

describe "Pages" do
  describe "About page" do
    it "should have proper title" do
      visit '/about'
      expect(page).to have_title('Справка')
    end
  end
end

describe "Users" do
  subject { page }
  
  describe "not logged in" do
    
    describe "have links" do
      before do
        visit root_path
      end
      it { should have_link('Вход', href: login_path) }
      it { should have_link('Регистрация', href: profile_path) }
      it { should_not have_link('Выход', href: login_path) }
    end
    
    describe "can register" do
      it "should increment users count" do
        expect {change_profile}.to change(User, :count).by(1)
        expect(page).to have_selector('div.alert.alert-success', text: "Профиль успешно сохранен")
      end
    end
  end
  
  describe "logged in" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
      # visit root_path
    end
    it { should have_selector('div.alert.alert-success', text: "Добро пожаловать, #{@user.name}!")}
    it { should_not have_link('Вход', href: login_path) }
    it { should_not have_link('Регистрация', href: profile_path) }
    it { should have_link('Выход', href: login_path) }
    it { should have_link(@user.name, href: profile_path) }

    describe "can update profile" do
      it "should not increment users count" do
        expect {change_profile}.not_to change(User, :count)
        expect(page).to have_selector('div.alert.alert-success', text: "Профиль успешно сохранен")
      end
    end
    describe "can logout" do
      before { click_link "Выход" }
      it { should have_selector('div.alert.alert-info', text: "Спасибо из использование сервиса, ждем Вас снова!")}
    end
  end

  describe "russian letters bug" do
    before do
      visit root_path
      fill_in 'parcel_num', with: "123456789ф"
      click_button 'Проверить'
      fill_in 'parcel_num', with: "123456789ф"
      click_button 'Проверить'
    end
    it { should_not have_selector('Трек код уже существует')}
  end

end