# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def activation_instructions
    user = User.first
    UserMailer.activation_instructions(user)
  end
end
