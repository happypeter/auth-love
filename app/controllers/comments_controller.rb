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
 
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
 
end
