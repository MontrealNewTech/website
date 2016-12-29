# frozen_string_literal: true
class Venue
  def self.find(id)
    new.find_from_eventbrite(id)
  end

  def find_from_eventbrite(id)
    parse Eventbrite::Load.new.venue(id)
  end

  private

  def parse(eventbrite_venue)
    "#{eventbrite_venue.name}, #{eventbrite_venue.address.localized_address_display}"
  end
end
