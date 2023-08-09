# frozen_string_literal: true
require 'rails_helper'

RSpec.describe LocationsController, type: :request do
  context do
    let(:location) { Location.create(name_location: 'Alvear') }
    let(:product) { Product.create(name_product: 'Cake') }
    let!(:stock) { StockPerLocation.create(location: location, product: product) }

    describe '#index' do
      it 'index' do
        get locations_path
        expect(assigns[:locations]).to eq([location])
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:ok)
        expect(response).to be_successful
      end
    end

    describe '#show' do
      it 'show' do
        get location_path(location)
        expect(response).to render_template(:show)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(location.name_location)
      end
    end

    describe '#new' do
      it 'new' do
        get new_location_path
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:ok)
        expect(assigns[:location]).to be_a(Location)
      end
    end

    describe '#create' do
      it 'is created' do
        expect {
          post locations_path, params: { location: { name_location: 'Guido' } }
        }.to change{ Location.count }.by(1).and change{ StockPerLocation.all.count }.by(1)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(locations_path)
      end

      it 'fails' do
        expect {
          post locations_path, params: { location: { name_location: '' } }
        }.to change{ Location.count }.by(0)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
        expect(response.body).to include("error")
      end
    end
  end
end