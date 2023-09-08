# frozen_string_literal: true
require 'rails_helper'
require './spec/shared_contexts/logged_user.rb'

RSpec.describe InventoriesController, type: :request do
  include_context 'logged user'

  let!(:inventory) { Inventory.create!(ingredient_id: Ingredient.create(name_ingredient: 'Flour').id) }

  describe 'Inventory#index' do
    it 'render Inventory#index template successfully' do
      get inventories_path
      expect(assigns[:inventories]).to eq([inventory])
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Inventory#update' do
    context 'when Inventory params are valid' do
      it 'update Inventory successfully and redirect to Inventory#index page' do
        patch inventory_path(inventory), params: { inventory: { quantity_inventory: 10 } }
        inventory.reload
        expect(inventory.quantity_inventory).to eq(10)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(inventories_path)
      end
    end

    context 'when Inventory params are invalid' do
      it 'display error message and redirect to Inventorys#index page' do
        patch inventory_path(inventory), params: { inventory: { quantity_inventory: -1 } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(inventories_path)
      end
    end
  end
end