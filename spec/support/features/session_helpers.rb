module Features
  module SessionHelpers
    def sign_in_as(who = :user)
      user = who.is_a?(User) ? who : FactoryGirl.build(:user).tap(&:save!)
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      expect(page).not_to have_text "Invalid email or password."
    end
  end
end
