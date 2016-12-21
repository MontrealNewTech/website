# frozen_string_literal: true
class Organization < ApplicationRecord
  mount_uploader :logo, ImageUploader

  validates :name, presence: true, uniqueness: true
  validate :logo_size

  private

  def logo_size
    errors.add(:logo, 'cannot be more than 5MB') if logo.size > 5.megabytes
  end
end
