require 'rails_helper'

RSpec.describe CommunityEvent do
  it { is_expected.to respond_to :title, :start_at, :description, :location, :link }

  describe 'accessors' do
    let(:params) do
      {
        title: 'A nice event title',
        start_at: 1.day.from_now,
        description: 'This is really going to be a great event',
        location: 'Notman House',
        link: 'http://123.com'
      }
    end

    it 'exposes getters for all of the initialization params' do
      [:title, :start_at, :description, :location, :link].each do |method|
        expect(described_class.new(**params).send(method)).to eq params[method]
      end
    end
  end
end
