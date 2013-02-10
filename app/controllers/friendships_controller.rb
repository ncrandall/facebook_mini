class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:id])

    if @friendship.save
      flash[:notice] = "Added Friend"
    else
      flash[:notice] = "Unable to add friend"
    end

    redirect_to user_path(current_user)
  end

  def destroy
    @friendship = current_user.friendships.where(:friend_id => params[:id])[0]
    @inverse_friendship = current_user.inverse_friendships.where(:friend_id => current_user.id)[0]

    if @friendship.destroy
      if !@inverse_friendship.nil?
        @inverse_friendship.destroy
      end
      flash[:success] = "Friendship was removed successfully"
    else
      flash[:error] = "There was an issue removing friend"
    end

    redirect_to user_path(current_user)
  end

end
