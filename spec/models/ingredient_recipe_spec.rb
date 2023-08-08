# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IngredientRecipe do
  describe 'associations' do
    it { is_expected.to belong_to(:recipe) }
    it { is_expected.to belong_to(:product) }

    describe 'validation' do
      it { is_expected.to validate_numericality_of(:quantity_recipe).is_greater_than_or_equal_to(0) }
    end
  end
end