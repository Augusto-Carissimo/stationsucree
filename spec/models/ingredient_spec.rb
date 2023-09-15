# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredient do
  describe 'validation' do
    it { is_expected.to validate_numericality_of(:quantity_ingredient).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_uniqueness_of(:name_ingredient) }
    it { is_expected.to validate_numericality_of(:last_price).is_greater_than_or_equal_to(0) }
  end
end
