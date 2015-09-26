require "rails_helper"

feature "User requests ride" do
  context "when available" do
    let!(:ride) { create(:ride, seat_count: 2) }
    scenario "it sends a ride request and displays user taking ride" do
      sign_in
      visit rides_path
      click_on "Take ride"
      expect{click_on "Confirm"}.to change{ride.passengers.count}.by(1)
      expect(page).to have_text "Thank you for your request"
      within "#ride_#{ride.id}" do
        expect(page).to have_text "Taking ride"
      end
    end
  end

  context "when one spot is left" do
    let!(:ride) { create(:ride) }
    scenario "it sends ride request and marks ride full" do
      sign_in
      visit rides_path
      click_on "Take ride"
      expect{click_on "Confirm"}.to change{ride.passengers.count}.by(1)
      expect(page).to have_text "Thank you for your request"
      within "#ride_#{ride.id}" do
        expect(page).to have_text "Ride full"
      end
    end
  end

  context "when ride is full" do
    let!(:ride) { create(:ride, passengers: [create(:passenger)]) }
    scenario "it cancles request with error message" do
      sign_in
      visit confirm_ride_path ride.id
      click_on "Confirm"
      expect(page).to have_text "Sorry this ride is now full"
      within "#ride_#{ride.id}" do
        expect(page).to have_text "Ride full"
      end
    end
  end
end
