# frozen_string_literal: true
require 'sinatra/base'

class FakeEventbrite < Sinatra::Base
  get '/v3/events/search/' do
    json_response 200, 'eventbrite_events.json' if params['organizer.id'] == EVENTBRITE[:organizer_id]
  end

  get '/v3/venues/:id/' do
    json_response 200, 'eventbrite_venue.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
