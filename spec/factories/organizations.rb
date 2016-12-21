# frozen_string_literal: true
FactoryGirl.define do
  factory :organization do
    sequence :name do |n|
      "Organization #{n}"
    end
  end
end
