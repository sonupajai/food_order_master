class HomesController < ApplicationController
autocomplete :city, :name
layout false, only: [:show]
  def index
  	@city=City.all  	
  end

  def show
  	@areas = City.find(params[:city_id]).areas
  end 

  def hotel_list
  	@area_id = params[:area_id]
    @area = Area.find(@area_id)
	  @hotels = @area.hotels
   
  end
end
