# frozen_string_literal: true
EVENT_ATTRIBUTES = [:title, :start_at, :end_at, :description, :location, :link].freeze

Event = KeywordStruct.new(*EVENT_ATTRIBUTES)
