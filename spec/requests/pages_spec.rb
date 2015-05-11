require 'rails_helper'

describe "Pages" do
  describe "About page" do
    it "should have proper title" do
      visit '/about'
      expect(page).to have_title('Справка')
    end
  end
end
