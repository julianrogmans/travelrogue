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
    if Ride.find(params[:passenger][:ride_id]).full?
      redirect_to rides_path, alert: "Sorry this ride is now full"
      return false
    elsif user_signed_in? && current_user.is_passenger? params[:passenger][:ride_id]
      redirect_to rides_path, alert: "You are already taking this ride"
      return false
    end
    Passenger.create params.require(:passenger).permit(:user_id, :ride_id)
    redirect_to rides_path, notice: "Thank you for your request"
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
