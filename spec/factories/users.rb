# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user_#{n}@example.com"
    end

    password 'password'

    trait :admin do
      after :create do |user|
        user.account.update(admin: true)
      end
    end
  end
end
