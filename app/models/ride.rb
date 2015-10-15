class Ride < ActiveRecord::Base
  has_many :shares
  has_many :riders, through: :shares, source: :user
  validates :origin, presence: true
  validates :destination, presence: true
  validates :seat_count, presence: true
  validates :date, presence: true
  validates :departure_time, presence: true

  def driver
    riders.references(:shares).find_by(shares: { driver: true })
  end

  def passengers
    riders.references(:shares).where(shares: { driver: false })
  end

  def full?
    seats_available < 1
  end

  def has_passenger?(passenger)
    shares.any? { |share| share.user_id == passenger.id }
  end

  def add_passenger(passenger)
    shares.create user: passenger, driver: false
  end

  def add_driver(driver)
    shares.create user: driver, driver: true
  end

  def seats_available
    seat_count - passengers.count
  end
end
