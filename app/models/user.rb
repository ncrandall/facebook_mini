class User < ActiveRecord::Base
  attr_accessible :username

  validates :username, :presence => true, :uniqueness => true

  #Specify the friendship from This Model -> Other User
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  
  #Specify the inverse friendship from Other User -> This User
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => :friend_id, :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  # callback functions for saving user
  before_validation { |user| user.username = user.username.downcase.strip }

  before_save :generate_token


  # check if there's a friendship in both users' friends
  def friend_of?(user)
    !friends.where(:id => user.id)[0].nil? && !inverse_friends.where(:id => user.id)[0].nil?
  end

  # check if there's a friendship request from the user
  def friend_request_received?(user)
    friends.where(:id => user.id)[0].nil? && !inverse_friends.where(:id => user.id)[0].nil?
  end

  # check if the user is awaiting a response to the friend request
  def friend_request_sent?(user)
    !friends.where(:id => user.id)[0].nil? && inverse_friends.where(:id => user.id)[0].nil?
  end

  # get friends list
  def friend_list
     friend_arr = []
     friends.each do |f|
       if(self.friend_of?(f))
         friend_arr.push(f)
       end
     end

     friend_arr
  end

  # get friend requests list 
  def friend_request_list
    friend_request_arr = []

    inverse_friends.each do |f|
      if self.friend_request_received?(f)
        friend_request_arr.push(f)
      end
    end

    friend_request_arr
  end


  # get awaiting requests list 
  def awaiting_friend_request_list
    friend_request_arr = []

    friends.each do |f|
      if f.friend_request_received?(self)
        friend_request_arr.push(f)
      end
    end

    friend_request_arr
  end

  private

    def generate_token
      self.session_token = SecureRandom.urlsafe_base64
    end
end
