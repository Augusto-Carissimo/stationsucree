# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validation' do
    it { is_expected.to validate_uniqueness_of(:username) }
  end
end
