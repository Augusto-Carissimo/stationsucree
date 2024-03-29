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

  describe 'Product#edit' do
    it 'render Product#edit template successfully' do
      get edit_product_path(product)
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:ok)
      expect(response).to be_successful
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
        expect(response.request.flash[:notice]).to include('error')
      end
    end
  end

  describe 'Product#update' do
    before do
      create(:subproduct_recipe, recipe: product.recipe)
      create(:ingredient_recipe, recipe: product.recipe, ingredient: sugar, quantity_recipe: 2)
    end

    let(:sugar) { create(:ingredient, name_ingredient: 'Sugar', quantity_ingredient: 20) }
    let!(:product) { create(:recipe).product }

    context 'when update commit message is Produce' do
      it 'when params are valid update Product.quantity_product successfully and redirect to Product#index page' do
        patch product_path(product.id), params: { product: { quantity_product: 10 } }
        expect(product.reload.quantity_product).to be(10)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
        expect(response.request.flash[:notice]).to include('updated')
      end

      it 'when params are invalid display error message and redirect to Product#index page' do
        patch product_path(product.id), params: { product: { quantity_product: -1 } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
      end

      it 'when there are not enough ingredients display error message and redirect to Product#index page' do
        patch product_path(product.id), params: { product: { quantity_product: 15 } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
        expect(response.request.flash[:notice]).to include('not enough')
      end
    end

    context 'when update commit message is Edit product' do
      it 'when params are valid update Product info successfully and redirect to Product#index page' do
        patch product_path(product.id), params: { commit: 'Edit product', product: { name_product: 'Alfajor' } }
        expect(product.reload.name_product).to eq('Alfajor')
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
        expect(response.request.flash[:notice]).to include('updated')
      end

      it 'when params are invalid display error message and redirect to Product#index page' do
        patch product_path(product.id), params: { commit: 'Edit product', product: { name_product: '' } }
        expect { product.reload }.not_to change(product, :name_product)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(products_path)
        expect(response.request.flash[:notice]).to include('error')
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
