class Ride < ActiveRecord::Base
  belongs_to :driver, class_name: :User, foreign_key: :user_id
  has_many :passengers
  validates :origin, presence: true
  validates :destination, presence: true
  validates :seat_count, presence: true
  validates :date, presence: true
  validates :departure_time, presence: true

  def full?
    passengers.count >= seat_count
  end
end
