# frozen_string_literal: true

require 'rails_helper'
require './spec/shared_contexts/logged_user'

RSpec.describe RecipesController do
  include_context 'when user is logged'

  let!(:recipe) { create(:recipe) }

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
    let!(:recipe_with_product) { create(:recipe) }
    let!(:ingredient) { create(:ingredient) }
    let(:product) { create(:product, name_product: 'Alfajor') }
    let(:subproduct) { create(:product, name_product: 'Tapas') }

    context 'when Recipe params are valid' do
      it 'create Recipe successfully and redirect to Recipe#index page' do # rubocop:disable RSpec/ExampleLength
        expect do
          post recipes_path,
               params: { recipe: { product_id: product.id, ingredient.name_ingredient => '1',
                                   subproduct.name_product => '1' } }
        end
          .to change(Recipe, :count).by(1)
          .and change { IngredientRecipe.all.count }.by(1)
          .and change { SubproductRecipe.all.count }.by(1)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(recipes_path)
      end
    end

    context 'when Recipe params are invalid' do
      it 'display error message and redirect to Recipe#new page' do
        expect { post recipes_path, params: { recipe: { product_id: recipe_with_product.product.id } } }
          .not_to change(Recipe, :count)

        expect(response).to redirect_to(new_recipe_path)
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'Recipe#update' do
    before do
      create(:ingredient_recipe, recipe:, quantity_recipe: 1)
      create(:subproduct_recipe, recipe:, quantity_recipe: 1)
    end

    it 'when params are valid update Recipe ingredient_recipe successfully and redirect to Recipe#show page' do
      patch recipe_path(recipe), params: { recipe: { recipe.ingredient_recipes.first.ingredient.name_ingredient => 2 } }
      expect(recipe.ingredient_recipes.first.quantity_recipe).to eq(2)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(recipe_path(recipe))
    end

    it 'when params are valid update Recipe subproduct_recipe successfully and redirect to Recipe#show page' do
      patch recipe_path(recipe), params: { recipe: { recipe.subproduct_recipes.first.product.name_product => 2 } }
      expect(recipe.subproduct_recipes.first.quantity_recipe).to eq(2)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(recipe_path(recipe))
    end

    it 'when params are invalid update Recipe ingredient_recipe successfully and redirect to Recipe#show page' do # rubocop:disable RSpec/ExampleLength
      patch recipe_path(recipe),
            params: { recipe: { recipe.ingredient_recipes.first.ingredient.name_ingredient => -1 } }
      expect(recipe.ingredient_recipes.first.quantity_recipe).to eq(1)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(recipe_path(recipe))
      expect(response.request.flash[:notice]).to include('negative')
    end
  end

  describe 'Recipe#destroy' do
    it 'delete Recipe' do
      expect do
        delete recipe_path(recipe)
      end.to change(Recipe, :count).by(-1)
    end
  end
end
