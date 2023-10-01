# frozen_string_literal: true

class SessionsController < ApplicationController
  def create # rubocop:disable Metrics/AbcSize
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = I18n.t 'sli'
    else
      flash[:error] = I18n.t 'wi'
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = I18n.t 'slo'
    redirect_to root_path
  end
end
