class PeterMailer < ActionMailer::Base
  default :from => "peter@happypeter.org"
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
