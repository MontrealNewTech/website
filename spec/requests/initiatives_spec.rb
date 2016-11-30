require 'rails_helper'

RSpec.describe "Initiatives", type: :request do
  describe "GET /initiatives" do
    it "works! (now write some real specs)" do
      get initiatives_path
      expect(response).to have_http_status(200)
    end
  end
end
