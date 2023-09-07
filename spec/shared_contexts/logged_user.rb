RSpec.shared_context 'logged user' do
  before do
    post login_path, params: { session: { username: user.username, password: 'test' } }
  end
  let(:user) { User.create(username: 'test', password: 'test') }
end