class UserMailer < ApplicationMailer
	def parent_welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Accell Educational')
  end

  def staff_welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Accell Educational')
  end
end
