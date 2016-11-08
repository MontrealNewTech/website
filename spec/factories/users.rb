FactoryGirl.define do
  factory :user do
    email
    password 'password'

    trait :admin do
      role :admin
    end
  end
end
