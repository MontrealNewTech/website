# frozen_string_literal: true
class PartnershipsController < ApplicationController
  def index
    @sponsors = Partnership.all
  end
end
