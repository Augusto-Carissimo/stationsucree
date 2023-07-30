# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredient do
  describe 'associations' do
    it { is_expected.to have_one(:inventory) }
  end

  describe 'validation' do
    it { is_expected.to validate_uniqueness_of(:name_ingredient) }
  end
end