# frozen_string_literal: true
FactoryGirl.define do
  factory :member_profile do
    association :user
  end
end
