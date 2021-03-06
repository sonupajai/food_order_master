class CitiesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  before_action :set_all_city, only: [ :index, :create, :update, :destroy]

  def index
     @city = City.new
  end

  def edit
  end

  def create
    @city = City.new(city_params)
    @city.save
  end

  def update
    @city.update(city_params)

  end

  def destroy
    @city.destroy

  end
  def delete
   @city = City.find(params[:city_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_city
      @city = City.find(params[:id])
    end
    def set_all_city
     @cities = City.all
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :user_id)
    end
end
