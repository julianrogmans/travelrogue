require "rails_helper"

feature "User creates a ride" do
  let(:new_user) { create :user }
  let(:origin) { Faker::Address.street_address }
  let(:time) { Faker::Time.forward(2, :morning) }
  before(:each) do
    sign_in_as new_user
    visit new_ride_path
  end

  scenario "with valid data" do
    fill_in "Origin", with: origin
    fill_in "Destination", with: Faker::Address.street_address
    fill_in "Seat count", with: 3
    fill_in "Date", with: Faker::Date.forward(2)
    fill_in "Departure time", with: time
    fill_in "Return time", with: time + 2.hours
    click_on "Create Ride"
    expect(page).to have_text "Your ride has been created"
  end

  scenario "with invalid data" do
    fill_in "Origin", with: origin
    click_on "Create Ride"
    expect(page).to have_selector(".errors")
  end
end
