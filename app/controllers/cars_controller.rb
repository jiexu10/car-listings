class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @manufacturers = Manufacturer.all
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to root_path, notice: 'Car Successfully Added!'
    else
      @manufacturers = Manufacturer.all
      render :new
    end
  end

  private

  def car_params
    params.require(:car).permit(:manufacturer_id, :color, :year, :mileage, :description)
  end
end
