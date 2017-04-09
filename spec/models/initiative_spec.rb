# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Initiative, type: :model do
  it { is_expected.to validate_presence_of :title       }
  it { is_expected.to validate_presence_of :description }

  it 'can store a translation in french for title and description' do
    initiative = create :initiative

    I18n.locale = :fr
    expect(initiative.title).to be_nil
    expect(initiative.description).to be_nil
  end
end
