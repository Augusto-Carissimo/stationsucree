class LocationsController < ApplicationController
  def index
    @locations = Location.distinct(:id).joins(stock_per_locations: :product)
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.create(params.require(:location).permit(
      :name_location, :address, :phone))
    if @location.save
      redirect_to location_path(@location)
    else
      flash[:notice] = "There's been an error."
      render 'new'
    end
  end
end
