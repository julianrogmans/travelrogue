require "rails_helper"

feature "Request ride" do
  let(:user) { create(:user) }
  let!(:ride) { create(:ride) }
  before(:each) { sign_in user }

  context "when ride available" do
    before(:each) do
      visit rides_path
      click_on "Take ride"
      expect { click_on "Confirm" }.to change{ride.passengers.count}.by(1)
      expect(page).to have_text "Thank you for your request"
    end

    context "with more then one spot left" do
      let(:ride) { create(:ride, seat_count: 2) }

      scenario "sends ride request and marks user as taking ride" do
        within "#ride_#{ride.id}" do
          expect(page).to have_text "Taking ride"
        end
      end
    end

    context "with one spot is left" do
      scenario "sends ride request and marks ride as full" do
        within "#ride_#{ride.id}" do
          expect(page).to have_text "Ride full"
        end
      end
    end
  end

  context "when user is already a passenger" do
    let!(:passenger) do
      create(:passenger, user_id: user.id, ride_id: ride.id)
    end

    scenario "cancles request with already taking ride message" do
      visit confirm_ride_path ride.id
      click_on "Confirm"
      expect(page).to have_text "You are already taking this ride"
    end
  end

  context "when ride is full" do
    let(:ride) { create(:ride, passengers: [create(:passenger)]) }

    scenario "cancles request with ride full message" do
      visit confirm_ride_path ride.id
      click_on "Confirm"
      expect(page).to have_text "Sorry this ride is now full"
    end
  end
end
