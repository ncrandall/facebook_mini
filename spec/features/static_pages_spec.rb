require 'spec_helper.rb'

describe "Static Pages" do

  describe "Home Page" do
    before { visit root_path }

    it "should have the content 'FriendCircle'" do
      page.should have_content("FriendCircle")
    end

    it "should send user to login page" do
      click_link "Get Started"
      page.should have_selector("input")
    end
  end

end
