require 'rails_helper'

RSpec.describe "Inventories", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/inventories/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/inventories/update"
      expect(response).to have_http_status(:success)
    end
  end

end
