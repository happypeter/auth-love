class UsersController < ApplicationController  
  def new  
    @user = User.new  
  end  
    
  def create  
 # this method is called when you click the "created user" button, then I see
 # in Firebug a "post users" request, so according to 
 # http://guides.rubyonrails.org/routing.html
 # the users#create will be called
    @user = User.new(params[:user])  
    if @user.save  
      redirect_to root_url, :notice => "Signed up!"  
    else  
      render "new"  
    end  
  end  
end  
  def index
      @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
