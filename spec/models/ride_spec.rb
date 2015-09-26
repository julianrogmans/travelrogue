require "rails_helper"

describe Ride do
  describe "#full" do
    let(:passenger) { create(:passenger) }
    let(:ride) { create(:ride, passengers: [passenger]) }
    it "should return true if passenger count is equal to ride seat count" do
      expect(ride).to be_full
    end
  end
end
