class SessionsController < ApplicationController  
  def new  
  end  
    
  def create  
  # called when "post sessions"
    user = User.authenticate(params[:name], params[:password])  
    if user  
      session[:user_id] = user.id # the session here, has nothing to do with the controller name Sessions, I will test this by using another controller name tommorrow! 
      redirect_to root_url, :notice => "Logged in!"  
    else  
      flash.now.alert = "Invalid email or password"  
      render "new" # new => ../views/sessions/new.html.er 
    end  
  end  

  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Hi, Logged out!"  
  end  
end  
