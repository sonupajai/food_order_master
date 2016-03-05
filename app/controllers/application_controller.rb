class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_notifications
  	if current_user.role=="admin"
  	Notification.where({to: "admin", status: "unread"}).all
  	else
  	Notification.where({to: current_user.id, status: "unread"}).all
  	end
  end

  helper_method :user_notifications
  def notification_count
     lastsen = current_user.lastseen
     @not_tot = Notification.where({:created_at.gte => (lastsen.created_at), :status => "unread" }).all.count.to_i
  end
   helper_method :notification_count
end
