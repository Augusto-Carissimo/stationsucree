# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :require_user

  def index
    @locations = Location.distinct(:id).includes(stock_per_locations: :product)
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def edit
    @location = Location.find(params[:id])
  end

  def create
    @location = Location.create(params.require(:location).permit(:name_location, :address, :phone))
    if @location.save
      stocks = Product.where(is_subproduct: false).map { |prod| { product_id: prod.id, location_id: @location.id } }
      StockPerLocation.insert_all(stocks) # rubocop:disable Rails::SkipsModelValidations
      redirect_to locations_path
    else
      flash[:notice] = I18n.t 'error'
      render 'new'
    end
  end

  def update
    @location = Location.find(params[:id])
    flash[:notice] = if @location.update(params.require(:location).permit(:address, :email, :phone))
                       I18n.t 'lu'
                     else
                       I18n.t 'error'
                     end
    redirect_to location_path
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to locations_path
  end
end
