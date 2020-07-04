class CabsController < ApplicationController
  before_action :authenticate_user!, except: %i[ cabs_list get_cab]
  before_action :set_param, only: %i[ show edit update destroy get_cab ]

  def index
    @cabs = Cab.paginate(page: params[:page])
  end

  # api actions
  def cabs_list
    @cabs = Cab.all
    render json: @cabs
  end

  def get_cab
    render json: @cab
  end

  def show

  end

  def download
    url, filename = Cab.fill_data

    send_file url,
              type: :ods,
              filename: filename,
              disposition: 'inline',
              x_sendfile: true
  end

  def new
    @cab = Cab.new
  end

  def create
    @cab = Cab.new(cab_params)

    if @cab.save
      redirect_to @cab, notice: t(:success)
    else
      flash.now[:alert] = t(:failed)
      render action: :new
    end
  end

  def edit

  end

  def update
    if @cab.update(cab_params)
      redirect_to @cab, flash: {info: t(:success)}
    else
      flash.now[:alert] = t(:failed)
      render action: :edit
    end
  end

  def destroy
    @cab.destroy
    respond_to do |format|
      format.html {redirect_to cabs_url}
      format.json {head :no_content}
    end
  end

  private

  def set_param
    @cab = Cab.find(params[:id])
  end

  def cab_params
    params.require(:cab).permit(:model, :plate_number, :mileage, :car_photo)
  end
end
