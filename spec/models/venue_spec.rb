require 'rails_helper'

RSpec.describe Venue do
  describe '.find' do
    let(:id) { 10 }
    let(:loader) { instance_double Eventbrite::Load, venue: eventbrite_venue }
    let(:eventbrite_venue) do
      JSON.parse({
        "address": {
          "address_1": "490 Rue de la Gaucheti\u00e8re O",
          "address_2": "null",
          "city": "Montr\u00e9al",
          "region": "Quebec",
          "postal_code": "H2Z 0B2",
          "country": "CA",
          "latitude": "45.5026029",
          "longitude": "-73.5638783",
          "localized_address_display": "490 Rue de la Gaucheti\u00e8re O, Montr\u00e9al, Quebec H2Z 0B2",
          "localized_area_display": "Montr\u00e9al, Quebec",
          "localized_multi_line_address_display": [
            "490 Rue de la Gaucheti\u00e8re O",
            "Montr\u00e9al, Quebec H2Z 0B2"
          ]
        },
        "resource_uri": "https://www.eventbriteapi.com/v3/venues/17757119/",
        "id": "17757119",
        "name": "Shopify",
        "latitude": "45.5026029",
        "longitude": "-73.5638783"
      }.to_json, object_class: OpenStruct)
    end

    before do
      allow(Eventbrite::Load).to receive(:new).and_return loader
    end

    subject { described_class.find(id) }

    it 'returns a nice string of the address' do
      expect(loader).to receive(:venue).with(id).and_return eventbrite_venue
      expect(subject).to eq "Shopify, 490 Rue de la Gauchetière O, Montréal, Quebec H2Z 0B2"
    end
  end
end
