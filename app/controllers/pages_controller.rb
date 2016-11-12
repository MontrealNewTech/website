class PagesController < ApplicationController
  def home
    @contact = Contact.new
    @sponsors = Organization.all
  end

  def about
  end
end
