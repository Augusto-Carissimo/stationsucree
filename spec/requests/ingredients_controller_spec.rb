# frozen_string_literal: true

require 'rails_helper'
require './spec/shared_contexts/logged_user'

RSpec.describe IngredientsController do
  include_context 'when user is logged'

  let!(:ingredient) { Ingredient.create(name_ingredient: 'Flour') }

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

  describe 'Ingredient#create' do
    context 'when Ingrendient params are valid' do
      it 'create Ingredient successfully and redirect to Inventory#index page' do
        expect { post ingredients_path, params: { ingredient: { name_ingredient: 'Butter' } } }
          .to change(Ingredient, :count).by(1)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(ingredients_path)
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
end
