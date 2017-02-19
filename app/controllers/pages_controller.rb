# frozen_string_literal: true
class PagesController < ApplicationController
  def home
    @events = Event.ours
  end

  def about
    @teams = Team.includes(:member_profiles)
  end
end
