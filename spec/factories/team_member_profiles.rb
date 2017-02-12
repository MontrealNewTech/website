# frozen_string_literal: true
FactoryGirl.define do
  factory :team_member_profile do
    association :user
  end
end
