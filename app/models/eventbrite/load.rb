# frozen_string_literal: true
module Eventbrite
  class Load
    def events
      Rails.cache.fetch 'mtl_newtech_eventbrite_events', expires_in: 10.minutes do
        (parse api_response_from(events_endpoint)).events
      end
    end

    def venue(id)
      Rails.cache.fetch "mtl_newtech_eventbrite_venue_#{id}", expires_in: 1.day do
        parse api_response_from(venues_endpoint_for(id))
      end
    end

    private

    def parse(response)
      JSON.parse(response.body, object_class: OpenStruct)
    end

    def api_response_from(endpoint)
      Net::HTTP.start(endpoint.hostname, endpoint.port, use_ssl: true) do |http|
        http.request authorized_request_to(endpoint)
      end
    end

    def authorized_request_to(endpoint)
      Net::HTTP::Get.new(endpoint).tap do |request|
        request['Authorization'] = "Bearer #{ENV['EVENTBRITE_API_TOKEN']}"
      end
    end

    def events_endpoint
      URI "#{EVENTBRITE[:api]}events/search/?organizer.id=#{EVENTBRITE[:organizer_id]}"
    end

    def venues_endpoint_for(id)
      URI "#{EVENTBRITE[:api]}venues/#{id}/"
    end
  end
end
