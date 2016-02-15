class AreasController < ApplicationController
  before_action :set_city, only: [:index,:edit, :new, :create, :update]
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  def index
    @areas = Area.all
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
    @area.save
    @areas = Area.all
  end

  def update
    @area.update(area_params)
    @areas = Area.all
  end

  def destroy
    @area.destroy
    @areas = Area.all
    @area = Area.new
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
        @cities = City.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name, :pincode, :city_id)
    end
end
