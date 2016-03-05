class NotificationJob < ActiveJob::Base
  queue_as :default

  def perform(id, user_id)
    hotel = Hotel.find id
    current_user = User.find user_id
    notification=Notification.new
    notification.message="#{hotel.name} hotel's approval pending"
    notification.user=current_user
    notification.to="admin"
    notification.save
  end
end
