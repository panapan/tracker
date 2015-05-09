require 'rails_helper'

describe "Pages" do
  describe "GET /pages" do
    it "works! (now write some real specs)" do
      get root_path
      expect(response).to have_http_status(200)
      get about_path
      expect(response).to have_http_status(200)
    end
  describe "About page" do
    it "should have proper title" do
      visit '/about'
      expect(page).to have_title('Справка')
    end
  end

  end
end
