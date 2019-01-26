class MicropostsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = "画像が投稿されました！"
      redirect_to user_path(current_user)
    else
      @user = User.find_by(id: current_user)
      render 'users/post'
    end
  end

  def destroy
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
