require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  class NoLoggedInUser < UsersControllerTest
    def setup
      ActionMailer::Base.deliveries.clear
    end

    test 'should_get_new' do
      get :new
      assert_response 200
      assert_template layout: 'layouts/application'
    end

    test 'should_create_user' do
      assert_difference('User.count') do
        post :create, user: {
          username: 'theuser',
          email: 'theuser@email.org',
          password: 'asdqwe123',
          password_confirmation: 'asdqwe123'
        }
      end
      assert_redirected_to root_path
    end
  end

  class LoggedInUser < UsersControllerTest
    def setup
      @user = users(:lecturer)
      UserSession.create(@user)
    end

    test 'should_not_get_new' do
      get :new
      assert_response 302
      assert_redirected_to root_path
    end
  end
end
