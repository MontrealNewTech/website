# frozen_string_literal: true
class Partnership < ApplicationRecord
  extend Enumerize
  PARTNERSHIP_TYPES = %w(community_partner Partnership).freeze

  mount_uploader :logo, ImageUploader
  translates :name, :description
  globalize_accessors
  enumerize :relationship, in: PARTNERSHIP_TYPES, default: :community_partner

  validates :name, presence: true, uniqueness: true
  validates :relationship, presence: true, inclusion: { in: PARTNERSHIP_TYPES }
  validate :logo_size

  private

  def logo_size
    errors.add(:logo, 'cannot be more than 5MB') if logo.size > 5.megabytes
  end
end
