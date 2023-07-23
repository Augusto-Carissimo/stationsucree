class LocationsController < ApplicationController
  def index
    @locations = Location.distinct(:id).joins(stock_per_locations: :product)
  end

  def show
    @location = Location.find(params[:id])
  end
end
