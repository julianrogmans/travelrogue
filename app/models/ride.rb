class Ride < ActiveRecord::Base
  belongs_to :user
  validates :origin, presence: true
  validates :destination, presence: true
  validates :seat_count, presence: true
  validates :date, presence: true
  validates :departure_time, presence: true
end
