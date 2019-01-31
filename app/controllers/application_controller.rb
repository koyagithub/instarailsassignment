class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login, :notification_c
  
    private
    def not_authenticated
      redirect_to login_path, alert: "ログインしてください"
    end
    
    # Judge if notification of current_user exists
    def notification_c
        @notifications = Notification.find_by(user_id: current_user)
    end
end
