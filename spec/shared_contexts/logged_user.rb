# frozen_string_literal: true

RSpec.shared_context 'when user is logged' do
  before do
    post login_path, params: { session: { email: user.email, password: 'test' } }
  end

  let(:user) { User.create(email: 'test', password: 'test') }
end
