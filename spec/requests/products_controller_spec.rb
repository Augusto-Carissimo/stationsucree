# frozen_string_literal: true

require 'rails_helper'
require './spec/shared_contexts/logged_user'

RSpec.describe ProductsController do
  include_context 'when user is logged'

  let!(:product) { create(:product) }

  describe 'Product#index' do
    it 'render Product#index template successfully' do
      get products_path
      expect(assigns[:products]).to eq([product])
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Product#show' do
    before do
      create(:recipe, product:)
    end

    it 'render Product#show template successfully with Product info' do
      get product_path(product)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(product.name_product)
    end
  end

  describe 'Product#new' do
    it 'render Product#new template successfully' do
      get new_product_path
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:ok)
      expect(assigns[:product]).to be_a(Product)
    end
  end

  describe 'Product#create' do
    before do
      create(:location)
    end

    context 'when Product params are valid' do
      it 'create Product successfully and redirect to Product#index page' do
        expect { post products_path, params: { product: { name_product: 'Pie' } } }
          .to change(Product, :count).by(1)
          .and change { StockPerLocation.all.count }.by(1)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_recipe_path)
      end
    end

    context 'when Product params are invalid' do
      it 'display error message and redirect to Product#new page' do
        expect { post products_path, params: { product: { name_product: product.name_product } } }
          .not_to(change(Product, :count))

        expect(response).to render_template(:new)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('error')
      end
    end
  end

  describe 'Product#update' do
    let!(:product) { create(:ingredient_recipe).recipe.product }

    context 'when Product params are valid' do
      it 'update Product successfully and redirect to Product#index page' do
        patch product_path(product.id), params: { product: { quantity_product: 10 } }
        product.reload
        expect(product.quantity_product).to be(10)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end
    end

    context 'when Product params are invalid' do
      it 'display error message and redirect to Product#index page' do
        patch product_path(product.id), params: { product: { quantity_product: -1 } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe 'Product#destroy' do
    it 'delete Product' do
      expect do
        delete product_path(product)
      end.to change(Product, :count).by(-1)
    end
  end
end
