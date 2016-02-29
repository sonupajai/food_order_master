class MenusController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_hotel
  before_action :set_order_id, only: [:view_menu]
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = @hotel.menus.all
    @menu = Menu.new
  end
  def new
    @menu = @hotel.menus.build
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
    if session[:order_id]!=nil
    @order=Order.find(session[:order_id])
    if @order.hotel!=@hotel       
      @order.order_items.all.destroy
    end    
    end
    @sum=0
    @area_id=params[:area_id]
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
      params.require(:menu).permit(:name, :image)
    end
    def set_order_id
      if session[:order_id]==nil 
        current_user.orders.where(status: "new").destroy
        @order = Order.new
        @order.user=current_user
        @order.hotel= @hotel
        @order.save!
        session[:order_id]=@order.id
      end
    end
  
  end
