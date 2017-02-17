# frozen_string_literal: true
class Team < ApplicationRecord
  validates_presence_of :name, :description

  has_many :member_profiles
end
