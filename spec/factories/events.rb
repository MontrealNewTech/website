# frozen_string_literal: true
FactoryGirl.define do
  factory :event do
    name 'Awesome Event Name'
    description "It's going to be great"
    starts_at { Time.current }
  end
end
