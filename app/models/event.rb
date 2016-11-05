class Event < ApplicationRecord
  mount_uploader :cover_image, ImageUploader

  belongs_to :location

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :start_at

  validate :cover_image_size

  private

  def cover_image_size
    errors.add(:cover_image, 'cannot be more than 5MB') if cover_image.size > 5.megabytes
  end
end
