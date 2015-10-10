FactoryGirl.define do
  factory :ride do
    origin { Faker::Address.street_address }
    destination { Faker::Address.street_address }
    seat_count 1
    date { 1.day.from_now }
    departure_time { Time.now }

    after(:create) do |ride|
      ride.shares.create user: FactoryGirl.create(:user), driver: true
    end
  end
end
