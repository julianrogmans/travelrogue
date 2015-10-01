require "rails_helper"

feature "List rides" do
  let(:driver) { create(:user) }

  scenario "when signed in as a driver offering rides" do
    ride_of_driver = create(:ride, driver: driver)
    ride = create(:ride)

    sign_in_as driver

    expect(page).to have_content ride.origin
    expect(page).to have_no_content ride_of_driver.origin
  end

  scenario "when not signed in" do
    ride = create(:ride)

    visit rides_path

    expect(page).to have_content ride.origin
  end

  scenario "when no rides exist" do
    visit rides_path

    expect(page).to have_content "No rides"
  end
end
