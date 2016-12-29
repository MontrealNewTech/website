# frozen_string_literal: true
class PagesController < ApplicationController
  def home
    @contact = Contact.new
    @events = Event.ours
    @sponsors = Organization.all
  end

  def about
  end
end
