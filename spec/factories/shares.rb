FactoryGirl.define do
  factory :share do
    user
    ride

    trait :driver do
      driver true
    end

    trait :passenger do
      driver false
    end
  end

end
