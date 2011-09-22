class SessionsController < ApplicationController  
  def new  
    session[:return_to] = nil
    session[:return_to] = params[:return_to] if params[:return_to]
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
        redirect_to_target_or_default root_url, :notice => "Signed in successfully"
      else # for old users who have no auth_token
        user.generate_token(:auth_token)
        user.save
        if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end
        redirect_to_target_or_default root_url, :notice => "Signed in successfully"
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
