require "rails_helper"

feature "List rides" do

  scenario "when signed in as a driver offering rides" do
    driver = create :share, :driver
    other_ride = create :ride, :with_driver

    sign_in_as driver.user

    expect(page).to have_content other_ride.origin
    expect(page).to have_no_content driver.ride.origin
  end

  scenario "when not signed in" do
    ride = create :ride, :with_driver

    visit rides_path

    expect(page).to have_content ride.origin
  end

  scenario "when no rides exist" do
    visit rides_path

    expect(page).to have_content "No rides"
  end
end
