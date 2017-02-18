# frozen_string_literal: true
FactoryGirl.define do
  factory :partnership do
    sequence :name do |n|
      "Partnership #{n}"
    end
  end
end
