# frozen_string_literal: true
class Partnership < ApplicationRecord
  mount_uploader :logo, ImageUploader
  translates :name, :description
  globalize_accessors

  validates :name, presence: true, uniqueness: true
  validate :logo_size

  private

  def logo_size
    errors.add(:logo, 'cannot be more than 5MB') if logo.size > 5.megabytes
  end
end
