# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  let(:user) { create(:user) }

  describe 'Session#create' do
    context 'when user creating is successfull' do

    end

    context 'when user log in successfully' do
      it 'session[:user_id] == user.id and redirect_to root_path' do
        post login_path, params: { session: { email: user.email, password: user.password } }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(:found)
      end
    end

    context 'when user is invalid' do
      it 'session[:user_id] == nil and and redirect_to root_path' do
        post login_path, params: { session: { email: 'wrong_user', password: user.password } }
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'Session#destroy' do
    context 'when log out' do
      it 'destroy session' do
        post login_path, params: { session: { email: user.email, password: user.password } }
        expect(session[:user_id]).to eq(user.id)
        get logout_path
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe 'Session#logged_in_redirect' do
    context 'when try log in again' do
      it 'redirect to root_path' do
        post login_path, params: { session: { email: user.email, password: user.password } }
        post login_path, params: { session: { email: user.email, password: user.password } }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
