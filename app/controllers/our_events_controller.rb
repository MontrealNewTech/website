# frozen_string_literal: true
class OurEventsController < ApplicationController
  def index
    @events = Event.ours
  end
end
