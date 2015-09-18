class Ride < ActiveRecord::Base
  validates_presence_of :origin, :destination, :seat_count, :date, :departure_time
end
