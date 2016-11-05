FactoryGirl.define do
  factory :contact do
    sequence :email do |n|
      "user_#{n}@example.com"
    end
  end
end
