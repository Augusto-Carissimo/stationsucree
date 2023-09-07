# frozen_string_literal: true
require 'rails_helper'
require './spec/shared_contexts/logged_user.rb'

RSpec.describe RecipesController, type: :request do
  context do

    include_context 'logged user'

    let!(:recipe) { FactoryBot.create(:recipe) }
    let(:product) { FactoryBot.create(:product) }


    describe '#index' do
      it 'index' do
        get recipes_path
        expect(assigns[:recipes]).to eq([recipe])
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:ok)
      end
    end

    describe '#show' do
      it 'show' do
        get recipe_path(recipe)
        expect(response).to render_template(:show)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(recipe.product.name_product)
      end
    end

    describe '#new' do
      it 'new' do
        get new_recipe_path
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:ok)
        expect(assigns[:recipe]).to be_a(Recipe)
      end
    end

    describe '#create' do
      let(:product) { FactoryBot.create(:product) }
      let!(:recipe_with_product) { FactoryBot.create(:recipe) }
      let!(:ingredient) { FactoryBot.create(:ingredient) }

      it 'is created' do
        expect {
          post recipes_path, params: { recipe: { product_id: product.id, ingredient.id.to_s => "1" } }
        }.to change{ Recipe.count }.by(1).and change { IngredientRecipe.all.count }.by(Ingredient.all.count)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(recipes_path)
      end

      it 'fails' do
        expect {
          post recipes_path, params: { recipe: { product_id: recipe_with_product.product.id } }
        }.to change{ Recipe.count }.by(0)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
        expect(response.body).to include("error")
      end
    end

    describe '#destroy' do
      it 'destroy' do
        expect {
          delete recipe_path(recipe)
        }.to change { Recipe.count }.by(-1)
      end
    end
  end
end