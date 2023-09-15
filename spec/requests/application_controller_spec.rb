# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do

  describe 'require_user' do
    context 'when try to access without log in' do
      it 'redirect to root_path' do
        get ingredients_path
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
