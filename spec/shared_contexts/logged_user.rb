# frozen_string_literal: true

RSpec.shared_context 'when user is logged' do
  before do
    post login_path, params: { session: { username: user.username, password: 'test' } }
  end

  let(:user) { User.create(username: 'test', password: 'test') }
end
