require 'rails_helper'

RSpec.describe PriceHistory, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:ingredient) }
  end

  describe 'validation' do
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
