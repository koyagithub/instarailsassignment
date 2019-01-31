class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(root_path, notice: 'ログイン成功！')
    else
      flash.now[:alert] = 'ログイン失敗'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_back_or_to(root_path, notice: 'ログアウトしました！')
  end
  
  #If user is logged in,redirect user to root path with notice
  def protect_login
    flash[:notice] = "すでにログインしています"
    redirect_to root_path
  end
end
