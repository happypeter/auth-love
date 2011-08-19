class SessionsController < ApplicationController  
  def new  
  end  
    
  def create  
    user = User.authenticate(params[:name], params[:password])  
    if user
      if user.auth_token  
        if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end
        redirect_to root_url, :notice => "Logged in!"
      else # for old users who have no auth_token
        user.generate_token(:auth_token)
        user.save
        if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end
        redirect_to root_url, :notice => "Logged in!"
      end
    else  
      flash.now.alert = "Invalid name or password"  
      render "new" 
    end  
  end  

  def destroy  
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "Hi, Logged out!"  
  end  
end  
