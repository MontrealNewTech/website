class PagesController < ApplicationController
  def home
    @contact = Contact.new
  end
end
