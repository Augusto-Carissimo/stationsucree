# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe do
  describe 'associations' do
    subject { create(:recipe) }

    it { is_expected.to have_many(:ingredient_recipes) }
    it { is_expected.to belong_to(:product) }
    it { is_expected.to validate_uniqueness_of(:product_id) }
  end

  describe 'methods' do
    before do
      create(:ingredient_recipe, recipe:, ingredient: sugar, quantity_recipe: 2)
      create(:subproduct_recipe, recipe:, product: subproduct, quantity_recipe: 2)
      create(:ingredient_recipe, recipe: recipe_of_subproduct, ingredient: flour, quantity_recipe: 1)
    end

    let!(:recipe) { create(:recipe, product: create(:product, name_product: 'Alfajor')) }
    let(:subproduct) { create(:product, name_product: 'Tapas') }
    let(:recipe_of_subproduct) { create(:recipe, product: subproduct) }
    let(:sugar) { create(:ingredient, name_ingredient: 'Sugar', last_price: 10) }
    let(:flour) { create(:ingredient, name_ingredient: 'Flour', last_price: 20) }

    it 'price_ingredients' do
      expect(recipe.price_ingredients).to eq(20)
    end

    it 'price_subproducts' do
      expect(recipe.price_subproducts).to eq(40)
    end

    it 'total_price' do
      expect(recipe.total_price).to eq(60)
    end

    it 'amount_ingriendent' do
      expect(recipe.amount_ingredient).to eq({ sugar.name_ingredient => 2.0 })
    end

    it 'amount_subproduct' do
      expect(recipe.amount_subproduct).to eq({ flour.name_ingredient => 1.0 })
    end

    it 'total_amount' do
      expect(recipe.total_amount).to eq({ sugar.name_ingredient => 2.0, flour.name_ingredient => 1.0 })
    end
  end
end
