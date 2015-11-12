class UserMailer < ApplicationMailer
  def activation_instructions(user)
    @user = user
    mail(to: @user.email, subject: 'Activation Instructions') do |format|
      format.text
      format.html
    end
  end
end
