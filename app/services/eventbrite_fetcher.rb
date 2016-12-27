# frozen_string_literal: true
class EventbriteFetcher
  # def initialize(eventbrite_events)
  #   @events = eventbrite_events
  # end

  def call
    eventbrite_events.map do |event|
      Event.new(**params_for(event))
    end

    # extract_events_from eventbrite_load
    #
    # eventbrite api json
    # extract events
    #   - build params
    #   - locations are separate request away
    #   - add location to event
    #   - build event
  end

  private

  def params_for(event)
    {
      description: event.description.html.html_safe,
      link: event.url,
      location: 'will get this later',
      start_at: Time.parse(event.start.local),
      title: event.name.text,
    }
  end

  # def eventbrite_load
  #   EventbriteLoad.new.our_events
  # end

  def json_events
    uri = URI "#{EVENTBRITE[:api]}events/search/?organizer.id=#{EVENTBRITE[:organizer_id]}"

    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "Bearer #{ENV['EVENTBRITE_API_TOKEN']}"

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    res.body
    # binding.pry
  end

  def eventbrite_events
    JSON.parse(json_events, object_class: OpenStruct).events
  end
end
