# frozen_string_literal: true
module Eventbrite
  class Load
    def initialize
      @uri = URI "#{EVENTBRITE[:api]}events/search/?organizer.id=#{EVENTBRITE[:organizer_id]}"
    end

    def events
      Rails.cache.fetch 'mtl_newtech_eventbrite_events', expires_in: 10.minutes do
        parsed_response.events
      end
    end

    private

    def parsed_response
      JSON.parse(api_response.body, object_class: OpenStruct)
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
end
