require "rails_helper"

describe Ride do
  describe "#full?" do
    let(:passenger) { create(:passenger) }
    let(:ride) { create(:ride, passengers: [passenger]) }
    it "should return true if #passengers equal or greater then seat count" do
      expect(ride).to be_full
    end
  end

  describe "#has_passenger?" do
    let(:user) { create(:user) }
    let(:ride) { create(:ride) }
    let!(:passenger) { create(:passenger, user_id: user.id, ride_id: ride.id) }
    it "should return true if user is a passenger" do
      expect(ride.has_passenger?(user)).to be_truthy
    end
  end
end
