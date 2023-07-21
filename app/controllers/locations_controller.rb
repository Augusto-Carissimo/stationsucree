class LocationsController < ApplicationController
  def index
    @locations = Location.distinct(:id).joins(stock_per_locations: :product)
  end

  def show
  end
end
