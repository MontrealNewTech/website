# frozen_string_literal: true
class PartnershipsController < ApplicationController
  def index
    @sponsors = Partnership.with_relationship(:partnership)
    @community_partners = Partnership.with_relationship(:community_partner)
  end
end
