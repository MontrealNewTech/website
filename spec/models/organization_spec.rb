require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { is_expected.to validate_presence_of :name        }
end
