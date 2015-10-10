require 'rails_helper'

describe User do
  it 'has a full name' do
    user = build_stubbed :user, first_name: "Bob", last_name: "Example"
    expect(user.full_name).to eq("Bob Example")
  end
end
