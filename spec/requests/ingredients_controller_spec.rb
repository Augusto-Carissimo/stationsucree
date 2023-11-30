# frozen_string_literal: true

require 'rails_helper'
require './spec/shared_contexts/logged_user'

RSpec.describe IngredientsController do
  include_context 'when user is logged'

  let!(:ingredient) { create(:ingredient) }

  describe 'Ingredient#index' do
    it 'render Ingredient#index template successfully' do
      get ingredients_path
      expect(assigns[:ingredients]).to eq([ingredient])
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
      expect(response).to be_successful
    end
  end

  describe 'Ingredient#show' do
    it 'render Ingredient#show template successfully with Ingredient info' do
      get ingredient_path(ingredient)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(ingredient.name_ingredient)
    end
  end

  describe 'Ingredient#new' do
    it 'render Ingredient#new template successfully' do
      get new_ingredient_path
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:ok)
      expect(assigns[:ingredient]).to be_a(Ingredient)
    end
  end

  describe 'Ingredient#edit' do
    it 'render Ingredient#edit template successfully' do
      get edit_ingredient_path(ingredient)
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:ok)
      expect(response).to be_successful
    end
  end

  describe 'Ingredient#create' do
    context 'when Ingrendient params are valid' do
      it 'create Ingredient successfully and redirect to Inventory#index page' do
        expect { post ingredients_path, params: { ingredient: { name_ingredient: 'Butter' } } }
          .to change(Ingredient, :count).by(1)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(ingredients_path)
      end

      it 'create new PriceHistory, PriceHistory#price == Ingredient#last_price' do
        expect { post ingredients_path, params: { ingredient: { name_ingredient: 'Butter', last_price: 100 } } }
          .to change { PriceHistory.all.count }.by(1)

        expect(PriceHistory.last.reload.price).to eq(Ingredient.last.reload.last_price)
      end
    end

    context 'when Ingrendient params are invalid' do
      it 'display error message and redirect to Ingredients#new page' do
        expect { post ingredients_path, params: { ingredient: { name_ingredient: '' } } }
          .not_to change(Ingredient, :count)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
        expect(response.body).to include('error')
      end
    end
  end

  describe 'Ingredient#update' do
    context 'when commit message from Ingredient#update is Add' do
      it 'when Ingredient params are valid: add to Ingredient.quantity_ingredient' do
        patch ingredient_path(ingredient), params: { commit: 'Add', ingredient: { quantity_ingredient: 10 } }
        expect(ingredient.reload.quantity_ingredient).to eq(10)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(ingredients_path)
      end

      it 'when try to add negative number: add to Ingredient.quantity_ingredient' do
        patch ingredient_path(ingredient), params: { commit: 'Add', ingredient: { quantity_ingredient: -10 } }
        expect(ingredient.reload.quantity_ingredient).to eq(0)
        expect(response).to redirect_to(ingredients_path)
      end
    end

    context 'when commit message from Ingredient#update is Edit' do
      it 'when Ingredient params are valid: add to Ingredient.quantity_ingredient' do
        patch ingredient_path(ingredient), params: { ingredient: { name_ingredient: 'Pies', last_price: 15 } }
        expect(ingredient.reload.name_ingredient).to eq('Pies')
        expect(ingredient.reload.last_price).to eq(15)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(ingredients_path)
      end

      it 'when try to add negative number: add to Ingredient.quantity_ingredient' do
        patch ingredient_path(ingredient), params: { commit: 'Edit', ingredient: { name_ingredient: '' } }
        expect(ingredient.reload.name_ingredient).to eq(ingredient.name_ingredient)
        expect(response).to redirect_to(ingredients_path)
      end

      it 'when price is update new PriceHistory, PriceHistory#price == Ingredient#last_price' do
        expect { patch ingredient_path(ingredient), params: { ingredient: { last_price: 200 } } }
          .to change { PriceHistory.all.count }.by(1)

        expect(PriceHistory.last.reload.price).to eq(ingredient.reload.last_price)
      end
    end
  end

  describe 'Ingredient#destroy' do
    it 'delete Ingredient' do
      expect { delete ingredient_path(ingredient) }.to change(Ingredient, :count).by(-1)
    end
  end
end
