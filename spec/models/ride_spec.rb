require "rails_helper"

describe Ride do
  let!(:ride) { create :ride }
  let(:driver) { create :user }
  let!(:passenger) { create :user }

  before(:each) do
    ride.add_driver driver
  end

  it "has a driver" do
    expect(ride.driver).to eq driver
  end

  describe "status" do
    context "when ride is full" do
      before do
        ride.add_passenger passenger
      end

      specify { expect(ride).to be_full }
    end

    context "with seats available" do
      it "has seats available" do
        expect(ride.seats_available).to eq(1)
        expect(ride).to_not be_full
      end
    end
  end

  describe "passengers" do
    context "when adding a passenger" do
      it "adds user as a passenger to the ride" do
        expect { ride.add_passenger(passenger) }.to(
          change { ride.seats_available }.by(-1))
        expect(ride.passengers).to eq [passenger]
      end
    end

    context "when user is a passenger" do
      before do
        ride.seat_count = 2
        ride.add_passenger(passenger)
      end
      it "prevents user from being added as a passenger" do
        expect(ride).to have_passenger(passenger)
      end
    end
  end
end
