# frozen_string_literal: true
class MemberProfile < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates_presence_of :user, :team

  delegate :email, to: :user, prefix: true, allow_nil: true
end
