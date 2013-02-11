require 'spec_helper'

describe User do

  let(:user1) { User.create(:username => 'bar') }
  let(:user2) { User.create(:username => 'foobar') } 
  let(:user3) { User.create(:username => 'foobarfoo') } 

  before { @user = User.new(:username => 'foo') }

  subject { @user }

  # Class Properties

  it { should respond_to(:username) }
  it { should respond_to(:friendships) }
  it { should respond_to(:session_token) }
  it { should be_valid }


  # Class Validations

  describe "username must be present" do
    before { @user.username = "" }

    it { should_not be_valid }
  end

  describe "session token" do
    before do
      @user.save
    end

    its(:session_token) { should_not be_blank }
  end

  describe "username must be unique" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.save 
    end

    it { should_not be_valid }

  end

  # Class Methods

  describe "friend requests" do
    before { @user.save }

    describe "when they aren't friends" do
      it { should_not be_friend_of(user1) }
      it { should_not be_friend_request_sent(user1) }
      it { should_not be_friend_request_received(user1) }
    end

    describe "when user sends a friend request" do
      before do
        @user.friendships.create(:friend_id => user1.id)
      end

      it { should_not be_friend_of(user1) }
      it { should be_friend_request_sent(user1) }
      it { should_not be_friend_request_received(user1) }
    end

    describe "when user1 sends a friend request" do
      before do
        user1.friendships.create(:friend_id => @user.id)
      end

      it { should_not be_friend_of(user1) }
      it { should_not be_friend_request_sent(user1) }
      it { should be_friend_request_received(user1) }
    end

    describe "when they are friends" do

      before do
        user1.friendships.create(:friend_id => @user.id)
        @user.friendships.create(:friend_id => user1.id)
      end

      it { should be_friend_of(user1) }
      it { should_not be_friend_request_sent(user1) }
      it { should_not be_friend_request_received(user1) }
    end
  end

  describe "friend list" do

    before do
      @user.save
      @user.friendships.create(:friend_id => user1.id)
      user1.friendships.create(:friend_id => @user.id)
      @user.friendships.create(:friend_id => user2.id)
      user2.friendships.create(:friend_id => @user.id)
      @user.friendships.create(:friend_id => user3.id)
    end

    its(:friend_list) { should include(user1) }
    its(:friend_list) { should include(user2) }
    its(:friend_list) { should_not include(user3) }
  end

  describe "request list" do
    before do
      @user.save
      @user.friendships.create(:friend_id => user1.id)
      user1.friendships.create(:friend_id => @user.id)
      user2.friendships.create(:friend_id => @user.id)
      user3.friendships.create(:friend_id => @user.id)
    end

    its(:friend_request_list) { should_not include(user1) }
    its(:friend_request_list) { should include(user2) }
    its(:friend_request_list) { should include(user3) }

  end
end
