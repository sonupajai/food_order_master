class MenusController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_hotel
  before_action :set_order_id, only: [:view_menu, :add_order_item, :reduce_order_item ]
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def view_menu
    @menus = @hotel.menus.all
    @order=Order.find(session[:order_id])
    @order_items=@order.order_items.all
    @sum=0
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
    @order=Order.find(session[:order_id])
    @order_items=@order.order_items.all
  end
  def delete_order_item
     @order=Order.find(session[:order_id])
     @order_item=@order.order_items.where(menu_item_id: params[:item_id]).first
     @order_item.destroy
     redirect_to confirm_order_path
  end
  def index
    @menus = @hotel.menus.all
    @menu = Menu.new
  end
  def show
  end
  # GET /menus/new
  def new
    @menu = @hotel.menus.build
  end
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = @hotel.menus.build(menu_params)
    @menu.hotel_id=@hotel.id
    @menu.save
    @menus = @hotel.menus.all
    # @menu = Menu.new(menu_params)
    # @menu.hotel_id = params[:hotel_id]
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    @menu.update(menu_params)
    @menus = @hotel.menus.all
    #@menu = @hotel.build_menu(menu_params)
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = @hotel.menus.find(params[:id])
    end

    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])    
      @delivery_area = DeliveryArea.where({ hotel_id: params[:hotel_id], area_id: params[:area_id] }).try(:first)
      #@delivery_area=DeliveryArea.first   
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :image, :user_id)
    end
    def set_order_id
      if session[:order_id]==nil 
        @order = Order.new
        @order.user=current_user
        @order.save!
        session[:order_id]=@order.id     
      end
  end
end
