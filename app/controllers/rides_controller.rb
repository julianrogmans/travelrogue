class RidesController < ApplicationController
  before_action :find_ride, only: [:show, :update, :confirm]

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
    ride = Ride.find(params[:passenger][:ride_id])
    ride_available = !(ride.full? && current_user.passenger?(ride))
    notice = "Thank you for your request"
    if ride.full?
      notice = "Sorry this ride is now full"
    elsif current_user.passenger?(ride)
      notice = "You are already taking this ride"
    end
    Passenger.create passenger_params if ride_available
    redirect_to rides_path, notice: notice
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

  def passenger_params
    params.require(:passenger).permit(:user_id, :ride_id)
  end
end
