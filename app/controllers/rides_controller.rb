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
    ride_available = (!ride.full? && !current_user.passenger?(ride))
    notice = set_notice(ride)
    Passenger.create passenger_params if ride_available
    redirect_to rides_path, notice: notice
  end

  private

  def set_notice(ride_requested)
    notice = case
    when current_user.passenger?(ride_requested)
      "You are already taking this ride"
    when ride_requested.full?
      "Sorry this ride is now full"
    else
      "Thank you for your request"
    end
  end

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
