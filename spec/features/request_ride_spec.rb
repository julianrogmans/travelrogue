require "rails_helper"

feature "User requests a ride" do
  scenario "when ride is available" do
    ride = create(:ride)
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
    passenger = create(:passenger)
    sign_in_as passenger.user

    visit rides_path

    within "#ride_#{passenger.ride.id}" do
      expect(page).to have_text "Taking ride"
    end
  end

  scenario "when ride is full" do
    passenger = create(:passenger)
    sign_in_as

    visit rides_path

    within "#ride_#{passenger.ride.id}" do
      expect(page).to have_text "Ride full"
    end
  end
end
