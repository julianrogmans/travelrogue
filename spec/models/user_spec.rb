require "rails_helper"

RSpec.describe User do
  let(:user) { build :user, first_name: "Bob", last_name: "Example" }

  it "has a full name" do
    expect(user.full_name).to eq "Bob Example"
  end
end
