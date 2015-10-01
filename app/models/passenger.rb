class Passenger < ActiveRecord::Base
  belongs_to :user
  belongs_to :ride

  validates :user_id, uniqueness: {
    scope: :ride_id, message: "you are already a passenger"
  }
end
