# frozen_string_literal: true
require 'rails_helper'
require './spec/shared_contexts/logged_user.rb'

RSpec.describe ProductsController, type: :request do
  context do

    include_context 'logged user'

    let!(:product) { Product.create(name_product: 'Cake') }

    describe '#index' do
      it 'successful ' do
        get products_path
        expect(assigns[:products]).to eq([product])
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:ok)
      end
    end

    describe '#show' do
      it 'successful ' do
        get product_path(product)
        expect(response).to render_template(:show)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(product.name_product)
      end
    end

    describe '#new' do
      it 'successful ' do
        get new_product_path
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:ok)
        expect(assigns[:product]).to be_a(Product)
      end
    end

    describe '#create' do
      let!(:location) { Location.create(name_location: 'Alvear') }
      it 'successful ' do
        expect {
          post products_path, params: { product: { name_product: 'Pie' } }
        }.to change{ Product.count }.by(1).and change{ StockPerLocation.all.count }.by(1)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end

      it 'fails' do
        expect {
          post products_path, params: { product: { name_product: '' } }
        }.to change{ Product.count }.by(0)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
        expect(response.body).to include("error")
      end
    end

    describe '#update' do
      let!(:product) { FactoryBot.create(:ingredient_recipe).recipe.product }
      let!(:Inventory) { Inventory.create(ingredient: product.recipe.ingredient_recipes.first.ingredient) }
      it 'successful ' do
        patch product_path(product.id), params: { product: { quantity_product: 10 } }
        product.reload
        expect(product.quantity_product).to be(10)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end

      it 'fails' do
        patch product_path(product.id), params: { product: { quantity_product: -1 } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end
    end

    describe '#destroy' do
      it 'successful ' do
        expect {
          delete product_path(product)
        }.to change { Product.count }.by(-1)
      end
    end
  end
end