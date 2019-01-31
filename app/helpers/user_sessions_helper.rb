module UserSessionsHelper
  # Return true if the user is logged in 
  def current_user?(user)
    user == current_user
  end
end
