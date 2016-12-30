# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user_#{n}@example.com"
    end

    password 'password'

    trait :admin do
      role 'admin'
    end
  end
end
