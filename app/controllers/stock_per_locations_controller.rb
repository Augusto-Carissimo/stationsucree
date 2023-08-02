class StockPerLocationsController < ApplicationController

  def edit
    @stock = StockPerLocation.find(params[:id])
  end

  def update
    @stock = StockPerLocation.find(params[:id])
    p '-'*50
    if params[:commit] == 'Sold'
      stock_params = params.require(:stock_per_location).permit(:quantity_stock)[:quantity_stock].to_i
      if @stock.update(quantity_stock: @stock.quantity_stock - stock_params)
        flash[:notice] = 'Stock updated'
        redirect_to locations_path
      else
        flash[:notice] = "There's been an error"
        redirect_to locations_path
      end
    else
      stock_params = params.require(:stock_per_location).permit(:quantity_stock)[:quantity_stock].to_i
      if @stock.update(quantity_stock: @stock.quantity_stock + stock_params)
        flash[:notice] = 'Stock updated'
        product = Product.find(@stock.product.id)
        product.update(quantity_product: product.quantity_product - stock_params)
        redirect_to locations_path
      else
        flash[:notice] = "There's been an error"
        redirect_to locations_path
      end
    end
  end
end
