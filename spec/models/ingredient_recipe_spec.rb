# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IngredientRecipe do
  describe 'associations' do
    it { is_expected.to belong_to(:recipe) }
    it { is_expected.to belong_to(:product) }
  end
end