# frozen_string_literal: true
class Location < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
end
