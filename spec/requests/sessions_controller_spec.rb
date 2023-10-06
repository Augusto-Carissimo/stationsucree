# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  let!(:user) { create(:user) }

  describe 'Session#create' do
    context 'when user sign up is successfull' do
      it 'create user and logs in' do
        post login_path, params: { commit: 'Sign up', session: { email: 'test@email.com', password: 'test' } }
        expect(session[:user_id]).not_to be_nil
        expect(response).to redirect_to(root_path)
        expect(User.count).to eq(3)
        expect(response.request.flash[:success]).to include('Sign up')
      end
    end

    context 'when user sign up fails' do
      it 'display error message' do
        post login_path, params: {
          commit: 'Sign up', session: { email: 'notexisting@email.com', password: 'test' }
        }
        expect(response.request.flash[:error]).to include('not authorized')
      end
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
