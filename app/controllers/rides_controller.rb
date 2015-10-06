class RidesController < ApplicationController
  before_action :find_ride, only: [:show, :update, :confirm, :send_request]

  def index
    @rides = Ride.all
  end

  def show
  end

  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)

    if @ride.save
      redirect_to ride_path(@ride.id)
    else
      render :new
    end
  end

  def confirm
  end

  def send_request
    @ride.add_passenger current_user
    flash[:success] = "Thank you for your request"
    redirect_to rides_path
  end

  private

  def find_ride
    @ride = Ride.find(params[:id])
  end

  def ride_params
    params.require(:ride).permit(
      :user_id,
      :origin,
      :destination,
      :seat_count,
      :date,
      :departure_time,
      :return_time
    )
  end
end
