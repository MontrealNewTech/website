class Team < ApplicationRecord
  validates_presence_of :name, :description

  has_many :team_member_profiles
end
