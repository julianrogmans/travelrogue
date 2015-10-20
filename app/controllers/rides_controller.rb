class RidesController < ApplicationController
  before_action :find_ride, only: [:show, :update, :confirm, :send_request]
  before_action :authenticate_user!, except: [:index]

  def index
    @rides = Ride.all
  end

  def show
  end

  def new
    @ride = Ride.new
  end

  def create
    @ride = current_user.rides.build(ride_params)

    if @ride.save
      @ride.add_driver current_user
      flash[:notice] = t "ride.save.success_html", url: ride_path(@ride)
      redirect_to root_path
    else
      render :new
    end
  end

  def confirm
  end

  def send_request
    @ride.add_passenger current_user
    redirect_to rides_path, notice: "Thank you for your request"
  end

  private

  def find_ride
    @ride = Ride.find(params[:id])
  end

  def ride_params
    params.require(:ride).permit(
      :origin,
      :destination,
      :seat_count,
      :date,
      :departure_time,
      :return_time
    )
  end
end
