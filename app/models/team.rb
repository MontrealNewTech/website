# frozen_string_literal: true
class Team < ApplicationRecord
  translates :name, :description

  validates_presence_of :name, :description

  has_many :member_profiles
end
