class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  before_filter :check_perm, :only => [ :edit, :update, :destroy ]

  def check_perm
    @post = Post.find(params[:id])
    # FIXME: this if sucks
    if current_user == nil
      flash[:notice] = "Sorry, you are not allowed to edit this post"
      redirect_to posts_path
    else 
      if @post.user_id != current_user.id 
        flash[:notice] = "Sorry, you are not allowed to edit this post"
        redirect_to posts_path
      end
    end
  end
  def index
    if params[:name]
      @user = User.where(:name => params[:name]).first
      #FIXME: when @user = nil,(the given name is not found in db) 
      #brower gives a error page, shall give a
      #warning and a redirct instead
      @posts = @user.posts
      # error
      # ruby-1.9.2-p180 :014 > posts = @user.posts
      # ActiveRecord::StatementInvalid: SQLite3::SQLException: no such column:
      # posts.user_id: SELECT "posts".* FROM "posts" WHERE ("posts".user_id =
      # 3)

    else
      @posts = Post.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id if current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    if @post.destroy
      flash[:notice] = "post deleted!"
    end
    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
