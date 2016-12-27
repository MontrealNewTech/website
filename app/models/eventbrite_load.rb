# frozen_string_literal: true
class EventbriteLoad
  def initialize
    @uri = URI "#{EVENTBRITE[:api]}events/search/?organizer.id=#{EVENTBRITE[:organizer_id]}"
  end

  def events
    Rails.cache.fetch 'mtl_newtech_eventbrite_events', expires_in: 10.minutes do
      parse_events_from api_response
    end
  end

  private

  def parse_events_from(response)
    JSON.parse(response.body, object_class: OpenStruct).events
  end

  def api_response
    Net::HTTP.start(@uri.hostname, @uri.port, use_ssl: true) do |http|
      http.request authorized_request
    end
  end

  def authorized_request
    Net::HTTP::Get.new(@uri).tap do |request|
      request['Authorization'] = "Bearer #{ENV['EVENTBRITE_API_TOKEN']}"
    end
  end
end
