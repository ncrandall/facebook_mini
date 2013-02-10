class User < ActiveRecord::Base
  attr_accessible :username

  validates :username, :presence => true, :uniqueness => true

  #Specify the friendship from This Model -> Other User
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  
  #Specify the inverse friendship from Other User -> This User
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => :friend_id, :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  before_save :generate_token


  # check if there's a friendship in both users' friends
  def friend?(user)
    !friends.where(:id => user.id)[0].nil? && !inverse_friends.where(:id => user.id)[0].nil?
  end


  private

    def generate_token
      self.session_token = SecureRandom.urlsafe_base64
    end
end
