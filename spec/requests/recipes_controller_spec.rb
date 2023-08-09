# frozen_string_literal: true
require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  context do
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

    # describe '#create' do
    #   # let!(:location) { Location.create(name_location: 'Alvear') }
    #   it 'is created' do
    #     expect {
    #       post recipes_path, params: { product: { name_product: 'Pie' } }
    #     }.to change{ Product.count }.by(1).and change{ StockPerLocation.all.count }.by(1)
    #     expect(response).to have_http_status(:found)
    #     expect(response).to redirect_to(products_path)
    #   end

    #   it 'fails' do
    #     expect {
    #       post products_path, params: { product: { name_product: '' } }
    #     }.to change{ Product.count }.by(0)
    #     expect(response).to have_http_status(:ok)
    #     expect(response).to render_template(:new)
    #     expect(response.body).to include("error")
    #   end
    # end

    # describe '#update' do
    #   it 'is updated' do
    #     patch product_path(product.id), params: { product: { quantity_product: 10 } }
    #     product.reload
    #     expect(product.quantity_product).to be(10)
    #     expect(response).to have_http_status(:found)
    #     expect(response).to redirect_to(products_path)
    #   end

    #   it 'fails' do
    #     patch product_path(product.id), params: { product: { quantity_product: -1 } }
    #     expect(response).to have_http_status(:found)
    #     expect(response).to redirect_to(products_path)
    #   end
    # end

    describe '#destroy' do
      it 'destroy' do
        expect {
          delete recipe_path(recipe)
        }.to change { Recipe.count }.by(-1)
      end
    end
  end
end