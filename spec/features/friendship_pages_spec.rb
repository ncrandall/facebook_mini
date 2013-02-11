require 'spec_helper.rb'

describe "Friendship Pages" do
  let(:user1) { User.create(:username => "foo") }
  let(:user2) { User.create(:username => "bar") }

  before { sign_in user1 }

  subject { page }

  describe "index page" do
    before { visit friendships_path }

    it { should have_selector("h1", :text => "Friendships") }
    it { should have_selector("h3", :text => "Sent Friend Requests") }
    it { should have_selector("h3", :text => "Received Friend Requests") }
    it { should have_selector("h3", :text => "Friends") }
  end

  describe "new friendship" do
    before { visit new_friendship_path }

    it { should have_selector("h1", :text => "Add Friends") }
    it { should have_selector("input") }

    describe "sending friend request" do
      before do
        fill_in "Username", :with => user2.username 
      end
     
      it "should add friendship" do
        expect { click_button "Add Friend" }.to change(Friendship, :count).by(1)
      end
    end
  end

  describe "remove friendship" do
    before do
      user1.friendships.create(:friend_id => user2.id)
      user2.friendships.create(:friend_id => user1.id)
      visit friendships_path
    end

    it { should have_link("remove") }

    it "should remove the friendship" do
      expect { click_link "remove" }.to change(Friendship, :count).by(-2)
    end
  end
end
