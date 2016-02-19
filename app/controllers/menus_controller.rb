class MenusController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_hotel
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  # GET /menus
  # GET /menus.json
  def index
    @menus = @hotel.menus.all
    @menu = Menu.new
    #@menu_categories_id = MenuCategory.find(:menu_categories_id)
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = @hotel.menus.build
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = @hotel.menus.build(menu_params)
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :image, :user_id)
    end
end
