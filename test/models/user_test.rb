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

  def test_with_valid_user
    assert @user.valid?
  end

  def test_without_username
    @user.username = ''
    assert_not @user.valid?
  end

  def test_without_email
    @user.email = ''
    assert_not @user.valid?
  end

  def test_without_password
    @user.password = ''
    @user.password_confirmation = ''
    assert_not @user.valid?
  end

  def test_with_not_match_password_confirmation
    @user.password_confirmation = 'asdqwe234'
    assert_not @user.valid?
  end

  def test_default_role_after_create
    @user.save
    assert_equal 'student', @user.role
  end

  def test_inactive_after_create
    @user.save
    assert_not @user.active?
  end

  def test_activate_user
    @user.save
    @user.activate!
    assert @user.active?
  end

  def test_has_many_courses_and_feeds
    @user.role = 'lecturer'
    @user.save
    assert @user.respond_to?(:courses)
    assert @user.respond_to?(:feeds)
  end

  def test_has_many_enrollments_and_enrolled_courses
    @user.save
    assert @user.respond_to?(:enrollments)
    assert @user.respond_to?(:enrolled_courses)
  end

  def test_find_login_by
    @user.save
    assert_equal @user, User.find_login_by('theuser')
    assert_equal @user, User.find_login_by('theuser@email.com')
  end
end
