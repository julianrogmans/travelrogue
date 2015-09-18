class RidesController < ApplicationController
  before_action :find_ride, only: [:show, :update]

  def new
    @ride = Ride.new
  end

  def show
  end

  def create
    @ride = Ride.new(ride_params)

    if @ride.save
      redirect_to ride_path(@ride.id)
    else
      render :new
    end
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
