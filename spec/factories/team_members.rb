# frozen_string_literal: true
FactoryGirl.define do
  factory :team_member do
    association :user
  end
end
