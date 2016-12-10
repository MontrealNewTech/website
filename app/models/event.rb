# frozen_string_literal: true
class Event < ApplicationRecord
  ATTRIBUTES = [:title, :start_at, :description, :location, :link].freeze

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged
  mount_uploader :cover_image, ImageUploader

  belongs_to :location

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :starts_at

  validate :cover_image_size

  delegate :name, to: :location, prefix: true, allow_nil: true

  private

  def cover_image_size
    errors.add(:cover_image, 'cannot be more than 5MB') if cover_image.size > 5.megabytes
  end

  def slug_candidates
    [
      :name,
      [:name, start_date],
      [:name, start_date, location_name]
    ]
  end

  def start_date
    starts_at.try(:to_date)
  end
end
