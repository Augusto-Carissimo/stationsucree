# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockPerLocation do
  describe 'associations' do
    it { is_expected.to belong_to(:location) }
    it { is_expected.to belong_to(:product) }
  end
end