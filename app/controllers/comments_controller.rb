class CommentsController < ApplicationController
  before_filter :check_perm, :only => [ :edit, :update, :destroy ]


  def check_perm
    # the check_perm here is not really very necessary, since if the reader is
    # not allowed to edit or delelte the comment, he won't even see the
    # links(hided in view), 
    # still this is nice to have as guardian code.
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if current_user == nil
      flash[:notice] = "Sorry, you are not allowed to edit or destory this post"
      redirect_to posts_path
    elsif @comment.user_id != current_user.id 
      flash[:notice] = "Sorry, you are not allowed to edit or destory this post"
      redirect_to posts_path
    end
  end
  def new
      @comment = Comment.new(:post_id => params[:post_id], :parent_id => params[:parent_id])
  end
  def index
    if params[:search]
      @comments = Comment.search(params[:search], params[:page])
    else
      @comments = Comment.all.reverse
      @comments = @comments.paginate :per_page => 30, :page => params[:page]
    end



    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end
 
  def create
    @comment = current_user.comments.build(params[:comment])
    @comment.user_id = current_user.id if current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(post_path(@comment.post), :notice => 'Comment was successfully created.') }
      else
        #FIXME: this is still not really User-friendly
        format.html { redirect_to(@comment.post,  :notice => @comment.errors) }
      end
    end
  end
  def edit
  end
  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') } 
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end
 
end
