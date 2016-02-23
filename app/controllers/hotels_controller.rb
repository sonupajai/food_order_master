class HotelsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_city, only: [:edit, :new, :create,:update]
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]

  def index
    @hotels = Hotel.order(name: :asc).page(params[:page]).per(5)
  end

  def new
    @hotel = Hotel.new
  end
  def edit
  end
  def create
    @hotel = Hotel.new(hotel_params)
    respond_to do |format|
      if @hotel.save
        format.html { redirect_to hotels_path, notice: 'Hotel was successfully created.' }
        format.json { render :show, status: :created, location: @hotel }
      else
        format.html { render :new }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to hotels_path, notice: 'Hotel was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end
    def set_city
        @cities = City.all
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params.require(:hotel).permit(:name, :type, :city_id, :speciality, :address, :image, :user_id)
    end
end
