class HomesController < ApplicationController
layout false, only: [:show]
  def index
  	@city=City.all
  end

  def show
  	@areas = City.find(params[:city_id]).areas
    session[:order_id]=nil 
  end 


  def hotel_list
  	@area_id = params[:area_id]
    @area = Area.find(@area_id)
	  @hotels = @area.hotels      
  end
  def show_rating
     @hotel=Hotel.find(params[:hotel_id])
     
  end
  def create_rating
      @hotel=Hotel.find(params[:hotel_id])
      @rating = Rating.new
      @rating.hotel=@hotel
      @rating.user=current_user
      @rating.rating_no=params[:ratings].count
      @rating.comment=params[:comments]
      if @rating.save
        @ratings=@hotel.ratings.all
        @ratings_tot= Rating.where(hotel_id: params[:hotel_id]).sum(:rating_no)
        @star=(@ratings_tot.to_i/(@ratings.count*5))*5
      end
  end

end
