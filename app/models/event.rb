class Event < ApplicationRecord
  belongs_to :location

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :start_at
end
