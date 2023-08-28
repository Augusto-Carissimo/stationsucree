class LocationsController < ApplicationController
  before_action :require_user

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
      Product.all.each do |product|
        StockPerLocation.create!(product_id: product.id, location_id: @location.id)
      end
      redirect_to locations_path
    else
      flash[:notice] = "There's been an error."
      render 'new'
    end
  end
end
