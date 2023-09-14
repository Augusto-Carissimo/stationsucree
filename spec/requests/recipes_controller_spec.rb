# frozen_string_literal: true
require 'rails_helper'
require './spec/shared_contexts/logged_user.rb'

RSpec.describe RecipesController, type: :request do
  include_context 'logged user'

  let!(:recipe) { FactoryBot.create(:recipe) }
  let(:product) { FactoryBot.create(:product) }


  describe 'Recipe#index' do
    it 'render Recipe#index template successfully' do
      get recipes_path
      expect(assigns[:recipes]).to eq([recipe])
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Recipe#show' do
    it 'render Recipe#show template successfully with Recipe info' do
      get recipe_path(recipe)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(recipe.product.name_product)
    end
  end

  describe 'Recipe#new' do
    it 'render Recipe#new template successfully' do
      get new_recipe_path
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:ok)
      expect(assigns[:recipe]).to be_a(Recipe)
    end
  end

  describe 'Recipe#create' do
    let!(:recipe_with_product) { FactoryBot.create(:recipe) }
    let!(:ingredient) { FactoryBot.create(:ingredient) }

    context 'when Recipe params are valid' do
      it 'create Recipe successfully and redirect to Recipe#index page' do
        expect {
          post recipes_path, params: { recipe: { product_id: product.id, ingredient.name_ingredient => "1" } }
        }.to change{ Recipe.count }.by(1)
        .and change { IngredientRecipe.all.count }.by(Ingredient.all.count)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(recipes_path)
      end
    end

    context 'when Recipe params are invalid' do
      it 'display error message and redirect to Recipe#new page' do
        expect {
          post recipes_path, params: { recipe: { product_id: recipe_with_product.product.id } }
        }.to change{ Recipe.count }.by(0)

        expect(response).to redirect_to(new_recipe_path)
        expect(response).to have_http_status(:found)
        expect(response.body).to include("Please select Product")
      end
    end
  end

  describe 'Recipe#destroy' do
    it 'delete Recipe' do
      expect {
        delete recipe_path(recipe)
      }.to change { Recipe.count }.by(-1)
    end
  end
end