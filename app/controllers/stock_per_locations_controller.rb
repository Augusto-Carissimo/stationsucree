class StockPerLocationsController < ApplicationController

  def edit
    @stock = StockPerLocation.find(params[:id])
  end

  def update
    @stock = StockPerLocation.find(params[:id])
    integer_params = params.require(:stock_per_location).permit(:quantity_product)[:quantity_product].to_i
    if @stock.update(quantity_product: @stock.quantity_product + integer_params)
      if integer_params.positive?
        product = Product.find(@stock.product_id)
        product.update(quantity: product.quantity - integer_params)
      end
      flash[:notice] = 'Stock updated'
      redirect_to locations_path
    else
      flash[:notice] = "There's been an error"
      redirect_to locations_path
    end
  end
end
