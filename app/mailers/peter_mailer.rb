class PeterMailer < ActionMailer::Base
  default :from => "peter@happycasts.net"
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
  def password_reset(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Password Reset")
  end
  def new_comment
    mail(:to => "happypeter<happypeter1983@gmail.com>", :subject => "New Comment at happypeter.org!")
  end
  def new_submit
    mail(:to => "happypeter<happypeter1983@gmail.com>", :subject => "New Submit at happypeter.org!")
  end
end
