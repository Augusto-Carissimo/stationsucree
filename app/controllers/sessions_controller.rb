# frozen_string_literal: true

class SessionsController < ApplicationController
  def create # rubocop:disable Metrics/AbcSize
      if params[:commit] == 'Sign up'
        signup
      else
        login
      end
      redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = I18n.t 'slo'
    redirect_to root_path
  end

  private

  def signup
    authorized_emails = ['augusto.carissimo@gmail.com', 's.furfaro@hotmail.com', 'test@email.com']
    if authorized_emails.include?(params[:session][:email]) && User.find_by(email: params[:session][:email]).nil?
      user = User.create!(email: params[:session][:email], password: params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = I18n.t 'sus'
    else
      flash[:error] = I18n.t 'ena'
    end
  end

  def login
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = I18n.t 'sli'
    else
      flash[:error] = I18n.t 'wi'
    end
  end
end
