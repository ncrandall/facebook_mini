class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:success] = "Welcome to FriendCircle"
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.where(id: params[:id])[0]

    if @user.nil?
      @user = User.new
      render 'new'
    end
  end

  def destroy
    @user = User.where(id: params[:id])[0]

    if @user
      if @user.destroy
        flash[:success] = "User account was successfully removed"
      else
        flash[:error] = "There was a problem unregistering the user"
      end
    else
      flash[:error] = "There was a problem finding the user to unregister"
    end
    redirect_to root_path
  end
end
