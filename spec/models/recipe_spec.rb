# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe do
  describe 'associations' do
    it { is_expected.to have_one(:ingredient_recipe) }
  end

  describe 'validation' do
    it { is_expected.to validate_uniqueness_of(:name_recipe) }
  end
end