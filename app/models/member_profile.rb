# frozen_string_literal: true
class MemberProfile < ApplicationRecord
  mount_uploader :image, ImageUploader
  translates :name, :position, :bio

  belongs_to :user
  belongs_to :team

  validates_presence_of :team, :name
  validate :image_size

  delegate :email, to: :user, prefix: true

  private

  def image_size
    errors.add(:image, 'cannot be more than 5MB') if image.size > 5.megabytes
  end
end
