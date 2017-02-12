# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Admin::TeamMembersController do
  it_behaves_like 'admin only controller'
end
