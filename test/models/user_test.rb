require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      username: 'theuser',
      email: 'theuser@email.com',
      password: 'asdqwe123',
      password_confirmation: 'asdqwe123'
    )
  end

  def teardown
    @user.destroy if @user
  end

  test 'with_valid_user' do
    assert @user.valid?
  end

  test 'without_username' do
    @user.username = ''
    assert_not @user.valid?
  end

  test 'without_email' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'without_password' do
    @user.password = ''
    @user.password_confirmation = ''
    assert_not @user.valid?
  end

  test 'with_not_match_password_confirmation' do
    @user.password_confirmation = 'asdqwe234'
    assert_not @user.valid?
  end

  test 'default_role_after_create' do
    @user.save
    assert_equal 'student', @user.role
  end

  test 'inactive_after_create' do
    @user.save
    assert_not @user.active?
  end

  test 'activate_user' do
    @user.save
    @user.activate!
    assert @user.active?
  end

  test 'has_many_courses_and_feeds' do
    @user.role = 'lecturer'
    @user.save
    assert @user.respond_to?(:courses)
    assert @user.respond_to?(:feeds)
  end

  test 'has_many_enrollments_and_enrolled_courses' do
    @user.save
    assert @user.respond_to?(:enrollments)
    assert @user.respond_to?(:enrolled_courses)
  end

  test 'test_find_login_by' do
    @user.save
    assert_equal @user, User.find_login_by('theuser')
    assert_equal @user, User.find_login_by('theuser@email.com')
  end
end
