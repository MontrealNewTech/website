# frozen_string_literal: true
class PagesController < ApplicationController
  def home
    @events = Event.ours
    @partnerships = Partnership.with_relationship(:partnership)
    @community_partners = Partnership.with_relationship(:community_partner)
  end

  def about
    @teams = Team.includes(:member_profiles)
  end

  def startupfest
  end
end
