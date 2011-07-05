class UserMailer < ActionMailer::Base
  default :from => "peter@happypeter.org"
  def registration_confirmation(user)  
     mail(:to => user.email, :subject => "Registered")  
  end  
end
