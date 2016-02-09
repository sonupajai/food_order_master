class DeliveryAreasController < ApplicationController
   before_action :set_delivery_area, only: [:show, :edit, :update, :destroy]
   before_action :set_city, only: [:new, :create]
   before_action :set_hotel, only:[:new, :create, :update, :destroy]
  def index
    @delivery_areas = DeliveryArea.all

  end

  def show
  end

  def new   
    @delivery_area = DeliveryArea.new
  end
 
  def edit
  end
  def create
    area_arr=params[:area_id]
    area_arr.each do |id|
      @delivery_area = DeliveryArea.new(delivery_area_params)
      @delivery_area.area_id = id
      @delivery_area.hotel_id = params[:hotel_id]
      area = Area.find(id)
      area.hotels << Hotel.find(params[:hotel_id])
      area.save! 
      respond_to do |format|
        if @delivery_area.save
          format.html { redirect_to hotels_path, notice: 'Delivery area was successfully created.' }
          format.json { render :show, status: :created, location: @delivery_area }
        else
          format.html { render :new }
          format.json { render json: @delivery_area.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  def update
    respond_to do |format|
      if @delivery_area.update(delivery_area_params)
        format.html { redirect_to @hotels_path, notice: 'Delivery area was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery_area }
      else
        format.html { render :edit }
        format.json { render json: @delivery_area.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /deliv# DELETE /hotelreas/1.json
  def destroy
    @delivery_area.destroy
    respond_to do |format|
      format.html { redirect_to delivery_areas_url, notice: 'Delivery area was successfully destroyed.' }
      format.json { head :no_content }
    end
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
