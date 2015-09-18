FactoryGirl.define do
  factory :ride do
    user
    origin { Faker::Address.street_address }
    destination { Faker::Address.street_address }
    seat_count 1
    date { 1.day.from_now }
    departure_time { Time.now }
  end

end
