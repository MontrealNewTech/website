# frozen_string_literal: true
class PagesController < ApplicationController
  def home
    @events = Event.ours
    @sponsors = Partnership.all
  end

  def about
    @teams = Team.includes(:member_profiles)
  end
end
