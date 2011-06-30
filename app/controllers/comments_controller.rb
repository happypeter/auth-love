class CommentsController < ApplicationController
  def index
    if params[:search]
      @comments = Comment.search(params[:search], params[:page])
    else
      @comments = Comment.all.reverse
      @comments = @comments.paginate :per_page => 5, :page => params[:page]
    end



    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end
 
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.user_id = current_user.id if current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@post, :notice => 'Comment was successfully created.') }
      else
        format.html { redirect_to(@post, :notice => @comment.errors) }
      end
    end
  end
  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end
  def update
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(root_url, :notice => 'Post was successfully updated.') } 
        #FIXME: how to get @post so thant I can redirect_to @post
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
 
end
