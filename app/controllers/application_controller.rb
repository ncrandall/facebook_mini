class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  private

    def correct_user
      @user = User.where(id: params[:id])[0]
      redirect_to(root_path) unless current_user?(@user)
    end

    def logged_in
      redirect_to new_session_path unless !current_user.nil?
    end
end
