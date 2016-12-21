# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'events/new', type: :view do
  before(:each) do
    assign(:event, Event.new(
                     name: 'MyString',
                     description: 'MyText',
                     duration: 1,
                     location: nil
    ))
  end

  xit 'renders new event form' do
    render

    assert_select 'form[action=?][method=?]', events_path, 'post' do
      assert_select 'input#event_name[name=?]', 'event[name]'

      assert_select 'textarea#event_description[name=?]', 'event[description]'

      assert_select 'input#event_duration[name=?]', 'event[duration]'

      assert_select 'input#event_location_id[name=?]', 'event[location_id]'
    end
  end
end
