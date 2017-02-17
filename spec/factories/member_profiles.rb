# frozen_string_literal: true
FactoryGirl.define do
  factory :member_profile do
    name { Faker::Name.name }
    association :user
    association :team
  end
end
