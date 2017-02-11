# frozen_string_literal: true
class PagesController < ApplicationController
  def home
    @events = Event.ours
    @sponsors = Organization.all
  end

  def about; end
end
