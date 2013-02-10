module SessionsHelper

  def sign_in(user)
    cookies.permanent[:session_token] = user.session_token
    self.current_user = user
  end

  def current_user
    @current_user ||= User.where(:session_token => cookies[:session_token])[0] 
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    current_user == user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil;
    cookies.delete(:session_token)
  end
end
