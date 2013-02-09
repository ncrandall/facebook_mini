require 'spec_helper'

describe Friendship do

  let(:user) { User.create(:username => "foo") }
  let(:friend) { User.create(:username => "bar") }
  let(:friendship) { user.friendships.build(friend_id: friend.id) }

  subject { friendship }

  it { should respond_to(:user_id) }
  it { should respond_to(:friend_id) }
  it { should respond_to(:accepted) }
  it { should be_valid }


  describe "when user id is not present" do
    before { friendship.user_id = nil }

    it { should_not be_valid }
  end

  describe "when friend id is not present" do
    before { friendship.friend_id = nil }

    it { should_not be_valid }
  end
end
