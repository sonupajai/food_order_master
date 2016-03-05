class HotelsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_action :set_city, only: [:edit, :new, :create,:update]
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :set_hotel_detail, only: [:add_order_item, :reduce_order_item, :confirm_order, :delete_order_item]
 
  def index
    @hotels = Hotel.order(name: :asc).page(params[:page]).per(5)
  end

  def new
    @hotel = Hotel.new
  end
  def edit
  end
  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user = current_user
    respond_to do |format|
      if @hotel.save
        NotificationJob.perform_now(@hotel.id.to_s, current_user.id.to_s)
        format.html { redirect_to hotels_path, notice: 'Hotel was successfully created.' }
        format.json { render :show, status: :created, location: @hotel }
      else
        format.html { render :new }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to hotels_path, notice: 'Hotel was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def authorized_hotels
      @hotels=Hotel.where(:status.ne=>"pending").all
  end
  def update_status
    @notification_statuses = Notification.where({to: "admin", status: "unread"}).all
    @notification_statuses.each do |not_stat|
      not_stat.status = "read"
      not_stat.save!
    end
    status=params[:status];
    @hotel = Hotel.find(params[:hotel_id])
    @hotel.status=status
    @hotel.update
    @notification=Notification.new
    @notification.message="Your #{@hotel.name} restaurant #{status}"
    @notification.user=current_user
    @notification.to=@hotel.user.id
    @notification.status = "read"
    @notification.save
    redirect_to authorize_hotels_path
  end
  def auth_hotel  
     @hotel = Hotel.find(params[:hotel_id])
  end
  def add_order_item
    @sum=0
    @order=Order.find(session[:order_id])
    @order_item=@order.order_items.where(menu_item_id: params[:item_id]).first
    if  @order_item.present?
      @order_item.inc(quantity:1) 
      @order_item.update!
    else
      @order_item = OrderItem.new
      @order_item.order= @order
      @order_item.menu_item=MenuItem.find(params[:item_id])
      @order_item.save!
    end
      @order_items=@order.order_items.all
  end
  def reduce_order_item
    @sum=0
    @order=Order.find(session[:order_id])
    @order_item=@order.order_items.where(menu_item_id: params[:item_id]).first
    if  @order_item.present?
        qty=@order_item.quantity
        qty-=1
        if qty>0
        @order_item.quantity=qty
        @order_item.update!
        else
        @order_item.destroy
        end
    end
    @order_items=@order.order_items.all
  end
  def confirm_order
    @area_id=params[:area_id]
    @order=Order.find(session[:order_id])
    @order_items=@order.order_items.all
  end
  def delete_order_item
     @order=Order.find(session[:order_id])
     @order_item=@order.order_items.where(menu_item_id: params[:item_id]).first
     @order_item.destroy
     redirect_to :back
  end
  def placed_order
    @order=Order.find(session[:order_id])
    @order.update(status: "confirm")
    session[:order_id]=nil 
    @notification=Notification.new
    @notification.message="Your order has been confirmed."
    @notification.user=current_user
    @notification.to=@current_user.id
    @notification.save
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end
    def set_city
        @cities = City.all
    end
     def set_hotel_detail
      @hotel = Hotel.find(params[:hotel_id])
      @delivery_area = DeliveryArea.where({ hotel_id: params[:hotel_id], area_id: params[:area_id] }).try(:first)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params.require(:hotel).permit(:name, :type, :city_id, :speciality, :address, :image, :user_id)
    end
  
end
