# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IngredientRecipe do
  describe 'associations' do
    it { is_expected.to belong_to(:recipe) }
    it { is_expected.to belong_to(:ingredient) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:quantity_recipe).is_greater_than_or_equal_to(0) }
  end

  describe 'methods' do
    let!(:ingredient_recipe) { create(:ingredient_recipe, recipe:, ingredient: sugar, quantity_recipe: 2) }
    let!(:sugar) { create(:ingredient, last_price: 10) }
    let!(:recipe) { create(:recipe, product: create(:product)) }

    it 'price_ingredient' do
      expect(ingredient_recipe.price_ingredient).to eq(20)
    end
  end
end
