class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_param, only: %i[ show edit update destroy]

  def index
    @cars = Car.paginate(page: params[:page])
  end

  def show

  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to @car, notice: t(:success)
    else
      flash.now[:alert] = t(:failed)
      render action: :new
    end
  end

  def edit

  end

  def update
    if @car.update(car_params)
      redirect_to @car, flash: {info: t(:success)}
    else
      flash.now[:alert] = t(:failed)
      render action: :edit
    end
  end

  def destroy
    @car.destroy
    respond_to do |format|
      format.html {redirect_to cars_url}
      format.json {head :no_content}
    end
  end

  private

  def set_param
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:model, :plate_number, :mileage, :car_photo)
  end
end
