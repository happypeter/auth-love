class UsersController < ApplicationController  
  before_filter :check_perm, :only => [ :edit, :update, :destroy ]

  def check_perm
    @user = User.find(params[:id])
    if current_user == nil
      flash[:notice] = "Sorry, plz login first"
      redirect_to posts_path
    elsif @user.id != current_user.id 
      flash[:notice] = "Sorry, you are not allowed to edit other's profile"
      redirect_to posts_path
    end
  end
  def new  
    @user = User.new  
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end  
    
  def create  
 # this method is called when you click the "created user" button, then I see
 # in Firebug a "post users" request, so according to 
 # http://guides.rubyonrails.org/routing.html
 # the users#create will be called
    @user = User.new(params[:user])  
    if @user.save  
      UserMailer.registration_confirmation(@user).deliver  
      session[:user_id] = @user.id # the session here, has nothing to do with the controller name Sessions, I will test this by using another controller name tommorrow! 
      redirect_to user_path(@user), :notice => "signed up!"  
    else  
      render "new"  
    end  
  end  
end  
  def index
      @users = User.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  def show
    if params[:name]
      @user = User.where(:name => params[:name]).first
    else
      @user = User.find(params[:id])
    end
    if @user == nil
      redirect_to root_url, :notice => "no such user!"  
    else
      respond_to do |format|
        format.html # show.html.erb
    end
  end
end
