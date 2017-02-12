# frozen_string_literal: true
FactoryGirl.define do
  factory :account do
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
