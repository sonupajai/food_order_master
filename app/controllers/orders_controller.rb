class OrdersController < ApplicationController
  def index
    @orders=current_user.orders.where(:status.ne=>"new").all   
  end
  def process_order  
  		@orders=Order.where(:status.ne=>"new").all   	
  end
  def auth_order
  	@order=Order.find(params[:order_id])
  end
  def order_status_update
  	status=params[:status]
  	@order=Order.find(params[:order_id])
  	@order.status=status
  	@order.update!
  	@notification=Notification.new
    @notification.message="order no. #{@order.id} has been #{status}"
    @notification.user=current_user
    @notification.to=@order.user.id
    @notification.save
    redirect_to :back
  end
  
end
