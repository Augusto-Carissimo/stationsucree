# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe do
  describe 'associations' do
    subject { create(:recipe) }

    it { is_expected.to have_many(:ingredient_recipes) }
    it { is_expected.to belong_to(:product) }
    it { is_expected.to validate_uniqueness_of(:product_id) }
  end
end
