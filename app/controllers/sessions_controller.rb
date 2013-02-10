class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.where(:username => params[:session][:username].downcase)[0]

    if user.nil?
      flash[:error] = "Couldn't login that user. click new user to create a new account"
      render 'new'
    else
      sign_in user
      redirect_to user
    end
      
  end

  def destroy
    if signed_in?
      sign_out
      flash[:success] = "Successfully logged out"
    else
      flash[:error] = "Unable to process request"    
    end

    redirect_to root_path

  end
end
