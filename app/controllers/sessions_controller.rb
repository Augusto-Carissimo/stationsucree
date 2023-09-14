# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:create]

  def create
    user = User.find_by(username: params[:session][:username])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = I18n.t 'sli'
    else
      flash.now[:error] = I18n.t 'wi'
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = I18n.t 'slo'
    redirect_to root_path
  end

  private

  def logged_in_redirect
    return unless logged_in?

    flash[:error] = I18n.t 'ali'
    redirect_to root_path
  end
end
