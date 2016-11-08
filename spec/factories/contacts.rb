FactoryGirl.define do
  sequence :email do |n|
    "user_#{n}@example.com"
  end

  factory :contact do
    email
  end
end
