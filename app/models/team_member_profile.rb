# frozen_string_literal: true
class TeamMemberProfile < ApplicationRecord
  belongs_to :user
  belongs_to :team
end
