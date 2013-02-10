require 'spec_helper'

describe User do

  before { @user = User.new(:username => 'foo') }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:friendships) }
  it { should respond_to(:requests) }
  it { should respond_to(:session_token) }
  it { should be_valid }

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
end
