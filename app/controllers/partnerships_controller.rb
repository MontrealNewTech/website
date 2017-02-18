class PartnershipsController < ApplicationController
  def index
    @sponsors = Partnership.all
  end
end
