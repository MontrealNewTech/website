# frozen_string_literal: true
class OurEventsController < ApplicationController
  def index
    @events = OurEvent.all
  end
end
