# frozen_string_literal: true
class Initiative < ApplicationRecord
  translates :title, :description

  validates_presence_of :title
  validates_presence_of :description
end
