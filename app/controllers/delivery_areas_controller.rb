class DeliveryAreasController < ApplicationController
   before_action :set_delivery_area, only: [:edit, :update, :destroy]
   before_action :set_city
   before_action :set_hotel, only:[:edit, :new, :create, :update, :destroy]
  
  def new   
    @delivery_area = DeliveryArea.new
    @delivery_areas = DeliveryArea.where(hotel_id: params[:hotel_id])
  end
 
  def create       
    area_arr=params[:area_id] #get multiple areas
    area_arr.each do |id|
      @delivery_area = DeliveryArea.new(delivery_area_params)
      @delivery_area.city = City.find(params[:city_id])
      @delivery_area.area_id = id
      @delivery_area.hotel_id = params[:hotel_id]     
      area = Area.find(id)
      area.hotels << Hotel.find(params[:hotel_id])
      area.save! 

      if @delivery_area.save 
         @delivery_areas = DeliveryArea.where(hotel_id: params[:hotel_id])
         @delivery_area = DeliveryArea.new
       end
    end
  end
  def edit
  end
  def delete
  end
  def update   
    if @delivery_area.update(delivery_area_params)  
    @delivery_areas = DeliveryArea.where(hotel_id: params[:hotel_id])
    @delivery_area = DeliveryArea.new
    end
  end

  def destroy
    @delivery_area.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_area
      @delivery_area = DeliveryArea.find(params[:id])

    end
    def set_city
      @city=City.all
    end
    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])
   end
    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_area_params
      params.require(:delivery_area).permit(:delivery_time, :delivery_charges, :min_order_amount)
    end
end
