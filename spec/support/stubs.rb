module Stubs
  def stub_eventbrite_events_call
    stub_request(:get, %r{https:\/\/www.eventbriteapi.com\/v3\/events\/search}).
      with(headers: { 'Authorization' => "Bearer #{ENV['EVENTBRITE_API_TOKEN']}" }).
      to_rack(FakeEventbrite)
  end
end
