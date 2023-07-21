require 'rails_helper'

RSpec.describe "StockPerLocations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/stock_per_locations/index"
      expect(response).to have_http_status(:success)
    end
  end

end
