class FriendshipsController < ApplicationController

  def new
    @user = User.new
  end

  def index
    @user = current_user
  end

  def show
    @user = User.where(:id => params[:id])[0]
  end

  def create

    if params[:id].nil?
      @friend = User.where(:username => params[:user][:username])[0] 
    else
      @friend = User.where(:id => params[:id])[0]
    end

    if !@friend.nil?
      @friendship = current_user.friendships.build(:friend_id => @friend.id)

      if @friendship.save
        flash[:success] = "Added Friend"
      else
        flash[:error] = "Unable to add friend"
      end
    else
      flash[:error] = "Couldn't find user to add as friend"
    end
    redirect_to user_path(current_user)
  end

  def destroy
    @friendship = current_user.friendships.where(:friend_id => params[:id])[0]
    @inverse_friendship = current_user.inverse_friendships.where(:user_id => params[:id])[0]

    if @friendship.nil? && @inverse_friendship.nil?
      flash[:error] = "There was an issue removing friendship"
    else
      @friendship.destroy unless @friendship.nil?
      @inverse_friendship.destroy unless @inverse_friendship.nil?

      flash[:success] = "Friendship was removed successfully"
    end

    redirect_to user_path(current_user)
  end

end
