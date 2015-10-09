class Ride < ActiveRecord::Base
  belongs_to :driver, class_name: :User, foreign_key: :user_id
  has_many :passengers
  validates :origin, presence: true
  validates :destination, presence: true
  validates :seat_count, presence: true
  validates :date, presence: true
  validates :departure_time, presence: true

  def full?
    passenger_count >= seat_count
  end

  def has_passenger?(user)
    passengers.any? { |passenger| passenger.user_id == user.id }
  end

  def add_passenger(passenger)
    passengers.create user: passenger
  end

  def passenger_count
    passengers.count
  end

  def seats_available
    seat_count - passenger_count
  end
end
