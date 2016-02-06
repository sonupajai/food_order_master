class HomesController < ApplicationController
autocomplete :city, :name

  def index
  	@city=City.all  	
  end

  def show
  	@areas = City.find(params[:city_id]).areas
  end 

  def hotel_list
  	@area_id = params[:area_id]
	  @hotels = Area.find(@area_id).hotels
  end
end
