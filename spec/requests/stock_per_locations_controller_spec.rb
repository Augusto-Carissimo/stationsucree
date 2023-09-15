# frozen_string_literal: true

require 'rails_helper'
require './spec/shared_contexts/logged_user'

RSpec.describe StockPerLocation do
  include_context 'when user is logged'

  let(:stock) { create(:stock_per_location, product:, location:, quantity_stock: 10) }
  let(:location) { create(:location) }
  let(:product) { create(:product, quantity_product: 10) }

  describe 'StockPerLocation#update' do
    context 'when commit message from Location#index is Transfer' do
      it 'when Location params are valid subtract from Product.quantity_product and add to Stock.quantity_stock' do
        patch stock_per_location_path(stock), params: { stock_per_location: { quantity_stock: 10 } }
        expect(product.reload.quantity_product).to eq(0)
        expect(stock.reload.quantity_stock).to eq(20)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(locations_path)
      end

      it 'when Location params are invalid redirect to Location#index' do
        patch stock_per_location_path(stock), params: { stock_per_location: { quantity_stock: 20 } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(locations_path)
      end
    end

    context 'when commit message from Location#index is Sold' do
      it 'when Location params are valid subtract from Stock.quantity_stock and redirect to Location#index' do
        patch stock_per_location_path(stock), params: { commit: 'Sold', stock_per_location: { quantity_stock: 10 } }
        stock.reload
        expect(stock.quantity_stock).to eq(0)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(locations_path)
      end

      it 'when Location params are invalid fails sold' do
        patch stock_per_location_path(stock), params: { commit: 'Sold', stock_per_location: { quantity_stock: 20 } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(locations_path)
      end
    end
  end
end
