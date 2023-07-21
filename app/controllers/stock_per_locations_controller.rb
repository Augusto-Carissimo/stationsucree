class StockPerLocationsController < ApplicationController
  def index
    @stocks = []
    locations.each do |location|
      @stocks << StockPerLocation.where(location_id: location)
    end
  end

  private

  def locations
    @locations ||= Location.all
  end
end
