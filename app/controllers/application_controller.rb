class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def user_notifications
  	if current_user.role=="admin"
  	Notification.where(to: "admin").all
  	else
  	Notification.where(to: current_user.id).all
  	end
  end
  helper_method :user_notifications
end
