class MicropostsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

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
    @micropost.destroy
    flash[:notice] = "投稿が削除されました！"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:picture)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
