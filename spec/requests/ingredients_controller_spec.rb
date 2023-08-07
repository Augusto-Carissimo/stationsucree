# frozen_string_literal: true
require 'rails_helper'

RSpec.describe IngredientsController, type: :request do
  context do
    let!(:ingredient) { Ingredient.create(name_ingredient: 'Flour') }

    describe '#show' do
      it 'show' do
        get ingredient_path(ingredient)
        expect(response).to render_template(:show)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(ingredient.name_ingredient)
      end
    end

    describe '#new' do
      it 'new' do
        get new_ingredient_path
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:ok)
        expect(assigns[:ingredient]).to be_a(Ingredient)
      end
    end

    describe '#create' do
      it 'is created' do
        expect {
          post ingredients_path, params: { ingredient: { name_ingredient: 'Butter' } }
        }.to change{ Ingredient.count }.by(1).and change{ Inventory.all.count }.by(1)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(inventories_path)
      end

      it 'fails' do
        expect {
          post ingredients_path, params: { ingredient: { name_ingredient: '' } }
        }.to change{ Ingredient.count }.by(0)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
        expect(response.body).to include("error")
      end
    end
  end
end