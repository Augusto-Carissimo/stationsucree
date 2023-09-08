# frozen_string_literal: true
require 'rails_helper'
require './spec/shared_contexts/logged_user.rb'

RSpec.describe StockPerLocation, type: :request do
  include_context 'logged user'

  let!(:stock) { StockPerLocation.create!(
    product_id: product.id,
    location_id: Location.create!(name_location: 'Guido').id,
    quantity_stock: 10)
  }

  let(:product) { Product.create!(name_product: 'Pie', quantity_product: 10) }

  describe 'StockPerLocation#update' do
    context 'commit message from Location#index is Transfer' do
      describe 'when Location params are valid' do
        it 'subtract from Product.quantity_product and add to StockPerLocation.quantity_stock. Redirect to Location#index' do
          patch stock_per_location_path(stock), params: { stock_per_location: { quantity_stock: 10 } }
          stock.reload
          product.reload
          expect(product.quantity_product).to eq(0)
          expect(stock.quantity_stock).to eq(20)
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(locations_path)
        end
      end

      describe 'when Location params are invalid' do
        it 'redirect to Location#index' do
          patch stock_per_location_path(stock), params: { stock_per_location: { quantity_stock: 20 } }
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(locations_path)
        end
      end
    end

    context 'when commit message from Location#index is Sold' do
      describe 'when Location params are valid' do
        it 'subtract from StockPerLocation.quantity_stock and redirect to Location#index' do
          patch stock_per_location_path(stock), params: { commit: 'Sold', stock_per_location: { quantity_stock: 10 } }
          stock.reload
          expect(stock.quantity_stock).to eq(0)
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(locations_path)
        end
      end

      describe 'when Location params are invalid' do
        it 'fails sold' do
          patch stock_per_location_path(stock), params: { commit: 'Sold', stock_per_location: { quantity_stock: 20 } }
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(locations_path)
        end
      end
    end
  end
end