require "rails_helper"

feature "List rides" do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  context "when rides exist" do
    let!(:ride1) { create(:ride, driver: user1) }
    let!(:ride2) { create(:ride, driver: user2) }

    context "when signed in" do
      scenario "shows rides offered by others" do
        sign_in user1
        expect(page).to have_content(ride2.origin)
        expect(page).to have_no_content(ride1.origin)
      end
    end

    context "when not signed in" do
      scenario "shows all rides" do
        visit rides_path
        expect(page).to have_content ride1.origin
        expect(page).to have_content ride2.destination
      end
    end
  end

  context "when no rides exist" do
    scenario "shows message indicating no rides" do
      visit rides_path
      expect(page).to have_content "No rides"
    end
  end
end
