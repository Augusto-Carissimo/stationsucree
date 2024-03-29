# frozen_string_literal: true

require 'rails_helper'
require './spec/shared_contexts/logged_user'

RSpec.describe LocationsController do
  include_context 'when user is logged'

  let(:location) { create(:location) }
  let(:product) { create(:product) }

  before do
    create(:stock_per_location, product:, location:)
  end

  describe 'Location#index' do
    it 'render Location#index template successfully' do
      get locations_path
      expect(assigns[:locations]).to eq([location])
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
      expect(response).to be_successful
    end
  end

  describe 'Location#show' do
    it 'render Location#show template successfully with Location info' do
      get location_path(location)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(location.name_location)
    end
  end

  describe 'Location#new' do
    it 'render Location#new template successfully' do
      get new_location_path
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:ok)
      expect(assigns[:location]).to be_a(Location)
    end
  end

  describe 'Location#edit' do
    it 'render Location#edit template successfully' do
      get edit_location_path(location)
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:ok)
      expect(response).to be_successful
    end
  end

  describe 'Location#create' do
    context 'when Location params are valid' do
      it 'create Location successfully and redirect to Location#index page' do
        expect { post locations_path, params: { location: { name_location: 'Guido' } } }
          .to change(Location, :count).by(1)
          .and change { StockPerLocation.all.count }.by(1)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(locations_path)
      end
    end

    context 'when Location params are invalid' do
      it 'display error message and redirect to Location#new page' do
        expect { post locations_path, params: { location: { name_location: '' } } }
          .not_to(change(Location, :count))

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
        expect(response.body).to include('error')
      end
    end
  end

  describe 'Location#update' do
    it 'when params are valid update Location info successfully and redirect to Location#show page' do
      patch location_path(location), params: { location: { name_location: 'Location' } }
      expect(location.reload.name_location).to eq('Location')
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(location_path(location))
    end

    it 'when params are invalid display error message and redirect to Location#show page' do
      patch location_path(location), params: { location: { name_location: '' } }
      expect { location.reload }.not_to change(location, :name_location)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(location_path(location))
    end
  end

  describe 'Location#destroy' do
    it 'delete Location' do
      expect do
        delete location_path(location)
      end.to change(Location, :count).by(-1)
    end
  end
end
