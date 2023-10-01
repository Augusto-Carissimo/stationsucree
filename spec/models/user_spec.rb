# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validation' do
    before do
      create(:user)
    end

    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
