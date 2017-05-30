# frozen_string_literal: true
require 'sinatra/base'

class FakeEventbrite < Sinatra::Base
  get '/v3/users/me/owned_events/' do
    json_response 200, 'eventbrite_events.json' if params['order_by'] == 'start_desc'
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
