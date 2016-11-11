class Organization < ApplicationRecord
  mount_uploader :logo, ImageUploader

  validates_presence_of :name

  validate :logo_size

  private

  def logo_size
    errors.add(:logo, 'cannot be more than 5MB') if logo.size > 5.megabytes
  end
end
