require "rails_helper"

feature "User profile" do
  let(:current_user) { create :user }
  before(:each) do
    sign_in_as current_user
    visit root_path
  end
  scenario "can be viewed" do
    click_on current_user.full_name
    within ".user" do
      expect(page).to have_text current_user.full_name
    end
  end

  scenario "can be edited" do
    click_on "Settings"
    fill_in "First Name", with: "Bob"
    fill_in "Last Name", with: "Example"
    fill_in "Current Password", with: '12345678'
    click_on "Update"
    expect(page).to have_text "Your account has been updated"
  end

  scenario "can be signed out of" do
    click_on "Sign Out"
    expect(page).to have_text "Signed out successfully"
  end

  scenario "can be deleted" do
    click_on "Settings"
    click_on "Cancel my account"
    expect(page).to have_text "successfully cancelled"
  end
end
