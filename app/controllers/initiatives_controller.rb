class InitiativesController < ApplicationController
  def index
    @initiatives = Initiative.all
  end

  def show
  end
end