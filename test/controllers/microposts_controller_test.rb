require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

　#Comments
  def show 
    @micropost = Micropost.find(params[:id])
    @comment = Comment.new
    @user = User.find_by(id: @micropost.user_id)

  end
end
