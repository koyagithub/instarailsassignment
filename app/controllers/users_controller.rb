class UsersController < ApplicationController
  before_action :set_user, only: [:readme, :show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :readme, :new, :create, :activate]

  # GET /users
  # GET /users.json
  def index
      @user = User.all
    if logged_in?
      @user = current_user
    end
  end
  
  # GET /users/readme
  def readme
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'ご登録のメールアドレスにメールが送られました。アカウントの有効化をお願いします。' }
        format.json { render :root_path, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'ユーザー情報編集完了。' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /users/pass_edit
  def pass_edit
    @user = current_user
  end
  
  # PATCH /users/pass_edit
   def pass_update
     @user = params.require(:user).permit(:password, :password_confirmation)
     @user = User.find_by(id: current_user)
    if params[:user][:password].empty?
      @user.errors.add(:パスワード,  "が空です。")
      render 'pass_edit'
    elsif @user.update_attributes(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      auto_login(@user)
      flash[:notice] = "パスワードが変更されました！"
      redirect_to @user
    else
      render 'edit'
    end
   end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'ユーザーは削除されました。' }
      format.json { head :no_content }
    end
  end
  
  #After clicking account activation link that's sent by koyagram
  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      auto_login(@user)
      flash[:notice] = 'アクティベーションに成功しました'
      redirect_to root_path
    else
      flash[:notice] = '既にアクティベーション済です'
      redirect_to root_path
    end
  end

  private
    # Set user 
    def set_user
      if logged_in?
        @user = User.find_by(id: current_user)
      else 
        @user = User.all
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :profile)
    end
end
