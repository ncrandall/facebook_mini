class User < ActiveRecord::Base
  attr_accessible :username

  validates :username, :presence => true, :uniqueness => true

  has_many :friendships, :dependent => :destroy
  has_many :requests, :foreign_key => "friend_id", :class_name => "Friendship", :dependent => :destroy

  before_save :generate_token


  private

    def generate_token
      self.session_token = SecureRandom.urlsafe_base64
    end
end
