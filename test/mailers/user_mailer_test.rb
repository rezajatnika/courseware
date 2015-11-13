require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def test_activation_instructions
    user = users(:testuser)
    mail = UserMailer.activation_instructions(user)

    assert_equal 'Activation Instructions', mail.subject
    assert_equal ['noreply@courseware.io'], mail.from
    assert_equal [user.email], mail.to

    assert_match user.username, mail.body.encoded
    assert_match user.perishable_token, mail.body.encoded
  end
end
