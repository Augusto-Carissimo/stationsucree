# frozen_string_literal: true
require 'rails_helper'

RSpec.describe InventoriesController, type: :request do
  context do
    let!(:inventory) { Inventory.create!(ingredient_id: Ingredient.create(name_ingredient: 'Flour').id) }

    describe '#index' do
      it 'index' do
        get inventories_path
        expect(assigns[:inventories]).to eq([inventory])
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:ok)
      end
    end

    describe '#update' do
      it 'is updated' do
        patch inventory_path(inventory), params: { inventory: { quantity_inventory: 10 } }
        inventory.reload
        expect(inventory.quantity_inventory).to eq(10)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(inventories_path)
      end

      it 'fails' do
        patch inventory_path(inventory), params: { inventory: { quantity_inventory: -1 } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(inventories_path)
      end
    end
  end
end