# frozen_string_literal: true
require 'rails_helper'

RSpec.describe StockPerLocation, type: :request do
  context do
    let!(:stock) { StockPerLocation.create!(
      product_id: product.id,
      location_id: Location.create!(name_location: 'Guido').id,
      quantity_stock: 10) }
    let(:product) { Product.create!(name_product: 'Pie', quantity_product: 10) }

    describe '#update' do
      it 'Transfer' do
        patch stock_per_location_path(stock), params: { stock_per_location: { quantity_stock: 10 } }
        stock.reload
        product.reload
        expect(product.quantity_product).to eq(0)
        expect(stock.quantity_stock).to eq(20)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(locations_path)
      end

      it 'Sold' do
        patch stock_per_location_path(stock), params: { commit: 'Sold', stock_per_location: { quantity_stock: 10 } }
        stock.reload
        expect(stock.quantity_stock).to eq(0)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(locations_path)
      end

      it 'fails transfer' do
        patch stock_per_location_path(stock), params: { stock_per_location: { quantity_stock: 20 } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(locations_path)
      end

      it 'fails sold' do
        patch stock_per_location_path(stock), params: { commit: 'Sold', stock_per_location: { quantity_stock: 20 } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(locations_path)
      end
    end

  end
end