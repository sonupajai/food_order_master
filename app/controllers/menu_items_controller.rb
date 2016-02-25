class MenuItemsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_action :set_hotel
  before_action :set_menu
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

  # GET /menu_items
  # GET /menu_items.json
  def index
    @menu_items = @menu.menu_items.all
    @menu_item = @menu.menu_items.build
  end

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
  end

  # GET /menu_items/new
  def new
    @menu_item = @menu.menu_items.build
  end

  # GET /menu_items/1/edit
  def edit
  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    @menu_item = @menu.menu_items.build(menu_item_params)
    @menu_item.save
    @menu_items = @menu.menu_items.all
  end

  # PATCH/PUT /menu_items/1
  # PATCH/PUT /menu_items/1.json
  def update
    @menu_item.update(menu_item_params)
    @menu_items = @menu.menu_items.all
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    @menu_item.destroy
    @menu_items = @menu.menu_items.all
    @menu_item = @menu.menu_items.build
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = @menu.menu_items.find(params[:id])
    end

    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])
    end

    def set_menu
      @menu = @hotel.menus.find(params[:menu_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :price, :quantity, :description, :discount, :user_id)
    end
end
