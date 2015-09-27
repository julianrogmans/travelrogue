class User < ActiveRecord::Base
  has_many :rides
  has_many :passengers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_passenger?(ride_id)
    Ride.find(ride_id).passengers.inject(false) do |memo, passenger|
      passenger.user_id == id ? true : memo
    end
  end
end
