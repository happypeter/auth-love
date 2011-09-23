class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  before_filter :check_perm, :only => [ :edit, :update, :destroy ]

  def vote
    @post = Post.find(params[:id])
    if params[:id]
      if session[:posts_voted] == nil
        session[:posts_voted] = []
      end
      session[:posts_voted].push(params[:id])
      flash[:notice] = "params[:id]=" + params[:id] + " " + "session[:posts_voted]=" +session[:posts_voted].to_s
      
      if @post.points.nil? # the initial value of points is NULL not 0, bad bad!!
        @post.points = 1
      else
        @post.points += 1
      end
      @post.save
      redirect_to post_path(@post)
    end
  end
  def check_perm
    @post = Post.find(params[:id])
    if current_user == nil
      flash[:notice] = "Sorry, you are not allowed to edit or destory this post"
      redirect_to posts_path
    elsif @post.user_id != current_user.id 
      flash[:notice] = "Sorry, you are not allowed to edit or destory this post"
      redirect_to posts_path
    end
  end
  def index
    if params[:search]
      @posts = Post.search(params[:search], params[:page])
    else
      @posts = Post.all.reverse
      @posts = @posts.paginate :per_page =>30, :page => params[:page]
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
