class CommentsController < ApplicationController
  def index
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @comment = Comment.new
    @comments = @micropost.comments.all
    @user = User.find_by(id: @micropost.user_id)
  end
  
  def create
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to micropost_comments_path(@micropost)
    else
      render micropost_comments_path(@micropost)
    end

  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
     redirect_to  request.referrer || root_url
  end

  private 

  def comment_params
    params.require(:comment).permit(:body )
  end

end
