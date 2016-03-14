class LoginPage

  include PageObject
  page_url('https://app.recurly.com/login')

  #Element definitions

  text_field(:username_input, id: 'user_email')
  text_field(:password_input, id: 'user_password')
  button(:login_button, id: 'submit_button')

  #Methods

  def login_user(username, password)
    self.username_input = username
    self.password_input = password
    self.login_button
  end

end