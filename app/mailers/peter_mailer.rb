class PeterMailer < ActionMailer::Base
  default :from => "peter@happypeter.org"
  def registration_confirmation(user)
  @user = user
  mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
end
