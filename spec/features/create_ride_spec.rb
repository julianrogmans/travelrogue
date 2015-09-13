require "rails_helper"
require "active_support"

feature 'User creates a ride' do
  let(:origin) { Faker::Address.street_address }
  let(:time) { Faker::Time.forward(2, :morning) }
  scenario 'with valid data' do
    visit new_ride_path
    fill_in :origin, with: origin
    fill_in :destination, with: Faker::Address.street_address
    fill_in :seat_count, with: 3
    fill_in :date, with: Faker::Date.forward(2)
    fill_in :departure_time, with: time
    fill_in :return_time, with: time + 2.hours
    click_on :submit
    expect(page).to have_content origin
  end
end
