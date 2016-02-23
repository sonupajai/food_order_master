class MenusController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_hotel
  before_action :set_order_id, only: [:view_menu, :add_order_item, :reduce_order_item ]
  before_action :set_menu, only: [:show, :edit, :update, :destroy]


  def index
    @menus = @hotel.menus.all
    @menu = Menu.new
  end
  def show
  end
  def new
    @menu = @hotel.menus.build
  end
  def edit
  end

  def create
    @menu = @hotel.menus.build(menu_params)
    @menu.hotel_id=@hotel.id
    if @menu.save
    @menus = @hotel.menus.all
    end
  end

  def update
   if  @menu.update(menu_params)
    @menus = @hotel.menus.all
   end
  end

  def destroy
    @menu.destroy
  end
  def view_menu
    @menus = @hotel.menus.all
    @order_items=@hotel.orders.find(session[:order_id]).try(:order_items) || []
   # @order=Order.find(session[:order_id])
    #@order_items=@order.order_items.all
    @sum=0
    @area_id=params[:area_id]
  end

  def add_order_item
    @sum=0
    @order=Order.find(session[:order_id])
    @order_item=@order.order_items.where(menu_item_id: params[:item_id]).first
    if  @order_item.present?
        qty=@order_item.quantity
        qty+=1
        @order_item.quantity=qty
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
    @hotel_id=params[:hotel_id]
    @order=Order.find(session[:order_id])
    @order_items=@order.order_items.all
  end
  def delete_order_item
     @order=Order.find(session[:order_id])
     @order_item=@order.order_items.where(menu_item_id: params[:item_id]).first
     @order_item.destroy 
     redirect_to :back
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = @hotel.menus.find(params[:id])
    end

    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])    
      @delivery_area = DeliveryArea.where({ hotel_id: params[:hotel_id], area_id: params[:area_id] }).try(:first)  
    end
    def menu_params
      params.require(:menu).permit(:name, :image, :user_id)
    end
    def set_order_id
      if session[:order_id]==nil 
        @order = Order.new
        @order.user=current_user
        @order.hotel= @hotel
        @order.save!
        session[:order_id]=@order.id     
      end
  end
end
