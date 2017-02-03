FactoryGirl.define do
  factory :account do
    role :user

    trait :admin do
      role :admin
    end
  end
end
