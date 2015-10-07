FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@travel.com"
  end

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { (18..55).to_a.sample }
    email
    password "12345678"
    password_confirmation "12345678"
  end

end
