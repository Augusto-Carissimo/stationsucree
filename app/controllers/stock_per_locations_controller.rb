class StockPerLocationsController < ApplicationController

  def edit
    @stock = StockPerLocation.find(params[:id])
  end

  def update
    @stock = StockPerLocation.find(params[:id])
    stock_params = params.require(:stock_per_location).permit(:quantity_product)[:quantity_product].to_i
    if @stock.update(quantity_product: @stock.quantity_product + stock_params)
      flash[:notice] = 'Stock updated'
      product = Product.find(@stock.product.id)
      product.update(quantity: product.quantity - stock_params)
      redirect_to locations_path
    else
      flash[:notice] = "There's been an error"
      redirect_to locations_path
    end
  end
end
