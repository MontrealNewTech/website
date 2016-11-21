class TeamMember < ApplicationRecord
  extend FriendlyId

  belongs_to :user

  delegate :name, to: :user

  friendly_id :slug_candidates, use: :slugged

  private

  def slug_candidates
    [
      :name,
      [:name, :position]
    ]
  end
end
