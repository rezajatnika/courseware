require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'test_invalid_information' do
    get new_user_path
    assert_no_difference('User.count') do
      post users_path, user: {
        username: '',
        email: 'invalid',
        password: 'asdqwe',
        password_confirmation: 'asdqwe'
      }
    end
    assert_template 'users/new'
  end

  test 'test_valid_information' do

    get new_user_path
    assert_difference('User.count') do
      post users_path, user: {
        username: 'username',
        email: 'user@email.net',
        password: 'asdqwe123',
        password_confirmation: 'asdqwe123'
      }
    end

    # Check for email deliveries
    assert_equal 1, ActionMailer::Base.deliveries.size

    # Assigns user
    user = assigns(:user)
    assert_not user.active?
    assert_nil controller.session['user_credentials']

    # Get user activation instructions
    activate_authlogic
    get activate_path(user.perishable_token)
    assert User.find_by_username(user.username).active?

    # User will automatically logged in
    assert_equal controller.session['user_credentials'], user.persistence_token
    assert_redirected_to root_path
  end
end
