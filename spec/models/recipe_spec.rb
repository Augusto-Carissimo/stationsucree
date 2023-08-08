# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe do
  describe 'associations' do
    it { is_expected.to have_one(:ingredient_recipe) }
    it { is_expected.to belong_to(:product) }
  end
end