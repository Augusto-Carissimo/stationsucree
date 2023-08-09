# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe do
  describe 'associations' do
    it { is_expected.to have_many(:ingredient_recipes) }
    it { is_expected.to belong_to(:product) }
  end
end