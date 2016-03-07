class AreasController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :set_city
  def index
    @areas = @city.areas.all.order_by(:name => 'asc')
    @area = Area.new
  end

  

  def show
  end

  def new
    @area = Area.new
  end

  def edit
  end

  def create
    @area = Area.new(area_params)
    @area.city=@city
   if @area.save
     @areas = @city.areas.all
   end
  end

  def update
    if @area.update(area_params)
     @areas = @city.areas.all
    end
  end

  def destroy
    if @area.destroy
      @areas = @city.areas.all
      @area = Area.new
    end
  end

  def delete
    @area = Area.find(params[:area_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end
    def set_city
      @city = City.find(params[:city_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name, :pincode)
    end
end
