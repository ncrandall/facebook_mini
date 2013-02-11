require 'spec_helper.rb'

describe "User Pages" do

  let(:user) { User.create(:username => 'foo') }

  subject { page }


  describe "Signup Page" do

    before { visit sign_up_path }

    it { should have_selector("input") }
    it { should have_selector("label", text: "Username") }

    describe "with valid information" do

      describe "Adding a new user" do
        before do
          fill_in "Username", :with => "foo"
        end
        it "should create a user" do
          expect { click_button "sign up" }.to change(User, :count).by(1)
        end
      end
    end

    describe "with invalid information" do
      before do
        click_button "sign up"
      end

      it { should have_selector("div", :text => "problem") }

    end
  end


  describe "Show User Page" do
    
    let(:other_user) { User.create(:username => "bar") }

    describe "logged in" do
      
      before do
        sign_in user
        visit user_path(user.id)
      end

      it { should have_selector("h1", text: "User Profile") }

      it { should have_link("View Friends") }
      it { should have_link("Add Friends") }
      it { should have_link("Remove Friends") }
      it { should have_link("Friend Requests") }
      it { should have_link("Unregister") }
      
      describe "Unregistering" do
        it "should delete the current user" do
          expect { click_link "Unregister" }.to change(User, :count).by(-1)
        end
      end

      describe "visiting a non-friend" do
        before { visit user_path(other_user.id) }

        it { should have_link("Add Friend") }
        it { should_not have_link("View Friends") }
      end

      describe "visiting a friend" do
        before do
          user.friendships.create(:friend_id => other_user.id)
          other_user.friendships.create(:friend_id => user.id)
          visit user_path(other_user.id)
        end

        it { should have_link("Remove Friend") }
        it { should have_link("View Friends") }
      end
    end

    describe "not logged in" do

      before { visit user_path(user.id) }

      it { should have_selector("h1", text: "User Profile") }
      it { should_not have_link("View Friends") }
      it { should_not have_link("Add Friends") }
      it { should_not have_link("Remove Friends") }
      it { should_not have_link("Friend Requests") }
      it { should_not have_link("Unregister") }

    end
  end
end
