class PagesController < ApplicationController
  def home
    @contact = Contact.new
  end

  def about
  end
end
