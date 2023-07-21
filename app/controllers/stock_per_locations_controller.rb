class StockPerLocationsController < ApplicationController

  def edit
    @stock = StockPerLocation.find(params[:id])
  end

  def update
    @stock = StockPerLocation.find(params[:id])
    if @stock.update(quantity_product: @stock.quantity_product + params.require(:stock_per_location).permit(
      :quantity_product)[:quantity_product].to_i)
      flash[:notice] = 'Stock updated'
      redirect_to locations_path
    else
      flash[:notice] = "There's been an error"
      redirect_to locations_path
    end
  end
end
