require "rails_helper"

describe Ride do

  let(:ride) { create(:ride) }
  let(:user) { create(:user) }
  # let(:passenger) { create(:passenger) }

  describe "when all seats are taken" do
    let(:ride) { create(:ride, seat_count: 1) }

    before do
      ride.add_passenger user
    end

    specify { expect(ride).to be_full }
  end

  describe "when user is a passenger" do
    let(:ride) { create(:ride, seat_count: 2) }

    before do
      ride.add_passenger user
    end

    specify { expect(ride.has_passenger?(user)).to be_truthy }
  end

  describe "when adding a passenger" do
    specify do
      expect { ride.add_passenger(user) }.to(
        change { ride.passengers.count }.by(1))
    end
  end
end
