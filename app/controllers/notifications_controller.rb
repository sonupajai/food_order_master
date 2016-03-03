class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all
   
  end
  def new
  	lastsen=current_user.lastseen
  	if lastsen.present?
  	current_user.lastseen.destroy  
  	end
  	lseen=Lastseen.new
  	lseen.user=current_user
  	lseen.save!
  end
end
