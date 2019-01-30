class CommentsController < ApplicationController
  def index
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @comment = Comment.new
    @comments = @micropost.comments.all
    @user = User.find_by(id: @micropost.user_id)
  end
  
  #Post comment and create notification when comment is posted
  def create
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user = current_user
    @user = @micropost.user
    if @comment.save
      #Create notification and insert comment.body and user of micropost and user of comment into notification
      @comment_n = Comment.find_by(id: @comment.id)
      @notification = @comment.notifications.build(n_comment: @comment_n.body,user_id: @user.id,comment_id: @comment.user)
      @notification.save 
      #Send email to user who posted micropost 
      UserMailer.send_mail(@user).deliver_now
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
