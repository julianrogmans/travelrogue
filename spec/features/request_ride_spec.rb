require "rails_helper"

feature "User requests a ride" do
  let!(:ride) { create :ride, :with_driver, seat_count: 2 }
  let!(:passenger) { create :user }

  before(:each) do
    ride.add_passenger passenger
  end

  scenario "when ride is available" do
    sign_in_as

    visit rides_path
    click_on "Take ride"
    click_on "Confirm"

    expect(page).to have_text "Thank you for your request"
    within "#ride_#{ride.id}" do
      expect(page).to have_text "Taking ride"
    end
  end

  scenario "when user is already a passenger" do
    sign_in_as passenger

    visit rides_path

    within "#ride_#{ride.id}" do
      expect(page).to have_text "Taking ride"
    end
  end

  scenario "when ride is full" do
    #fill second seat available
    ride.add_passenger create :user

    sign_in_as

    visit rides_path

    within "#ride_#{ride.id}" do
      expect(page).to have_text "Ride full"
    end
  end
end
