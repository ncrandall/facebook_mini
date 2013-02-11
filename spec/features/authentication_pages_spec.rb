require 'spec_helper.rb'

describe "Authentication Pages" do
  let(:user) { User.create(:username => "foo") }

  subject { page }

  describe "All pages" do
    before { visit root_path }

    describe "when not logged in" do
      it { should have_link "Login" }
    end

    describe "when logged in" do
      before { sign_in(user) } 
      it { should have_link "Log Out" }
    end

  end

  describe "Login Page" do

    before do
      visit log_in_path
      fill_in "Username", :with => user.username
    end

    it { should have_selector("h1", text: "Login") }
    it { should have_link("Sign Up") }

    describe "logging in" do
      before { click_button "login" }

      it { should have_selector("h1", text: "Profile") }
      it { should have_link("Log Out") }
    end

    describe "logging out" do

      before do
        click_button "login"
        click_link "Log Out"
      end

      it { should_not have_link("Log Out") }
    end
  end  
end
