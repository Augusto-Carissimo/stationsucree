# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location do
  describe 'associations' do
    it { is_expected.to have_many(:stock_per_locations) }
  end

  describe 'validation' do
    it { is_expected.to validate_uniqueness_of(:name_location) }
  end
end
