def sign_in(user)
  visit log_in_path
  fill_in 'Username', :with => user.username
  click_button 'login'
end
